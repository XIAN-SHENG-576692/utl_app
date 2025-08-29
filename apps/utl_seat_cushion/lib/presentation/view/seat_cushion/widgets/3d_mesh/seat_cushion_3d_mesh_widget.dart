import 'dart:async';
import 'dart:math';

import 'package:common_utils/dataset_color_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:synchronized/synchronized.dart';
import 'package:util_simple_3d/util_simple_3d.dart';
import 'package:simple_3d_renderer/simple_3d_renderer.dart';
import 'package:utl_seat_cushion/presentation/theme/theme_data.dart';

import '../../../../../domain/model/entity/seat_cushion_entity.dart';
import '../../../../../service/data_stream/seat_cushion_sensor.dart';
import '../../../../change_notifier/seat_cushion_sensor_data_manager.dart';

class _Buffer {
  final SeatCushionType type;
  Sp3dObj? obj;
  _Buffer(this.type);
}

class _WorldChangeNotifier extends ChangeNotifier {
  static _forceColor({
    required int force,
  }) {
    int index = SeatCushionParameters.forceMax - force;
    int length = SeatCushionParameters.forceMax - SeatCushionParameters.forceMin;
    return DatasetColorGenerator.rainbow(
      alpha: 1.0,
      index: index,
      length: length,
      hueMax: 255.0,
      hueMin: -45.0,
    );
  }


  late final List<_Buffer> _buffers = SeatCushionType.values.map((t) => _Buffer(t)).toList(growable: true);
  late Sp3dWorld world;
  // If you want to reduce distortion, shoot from a distance at high magnification.
  final camera = Sp3dCamera(
    Sp3dV3D(
      (SeatCushionParameters.basePosition(type: SeatCushionType.right).x + SeatCushionParameters.basePosition(type: SeatCushionType.left).x) / 2.0,
      (SeatCushionParameters.basePosition(type: SeatCushionType.right).y + SeatCushionParameters.basePosition(type: SeatCushionType.left).y) / 2.0,
      6000,
    ),
    6000,
    rotateAxis: Sp3dV3D(0.8, -0.8, -0.5),
    radian: -45,
  );
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  final Lock _lock = Lock();
  static List<List<Sp3dV3D>> _generateCushionBaseMesh(SeatCushionType type) {
    const rows = SeatCushionParameters.unitsMaxRow;
    const cols = SeatCushionParameters.unitsMaxColumn;
    const unitW = SeatCushionParameters.unitWidth;
    const unitH = SeatCushionParameters.unitHeight;

    final basePoint = SeatCushionParameters.basePosition(type: type);

    return List.generate(
      rows * cols,
      (index) {
        final row = (index / cols).floor();
        final col = (index % cols);
        final double centerX = (col - cols / 2) * unitW + unitW / 2;
        final double centerY = (row - rows / 2) * unitH + unitH / 2;

        final lt = Sp3dV3D(basePoint.x + (centerX - unitW / 2), basePoint.y + (centerY - unitH / 2), 0);
        final lb = Sp3dV3D(basePoint.x + (centerX - unitW / 2), basePoint.y + (centerY + unitH / 2), 0);
        final rb = Sp3dV3D(basePoint.x + (centerX + unitW / 2), basePoint.y + (centerY + unitH / 2), 0);
        final rt = Sp3dV3D(basePoint.x + (centerX + unitW / 2), basePoint.y + (centerY - unitH / 2), 0);

        return [lt, lb, rb, rt];
        // return [rt, rb, lb, lt];
      },
    );
  }
  static List<List<Sp3dV3D>> _generateSmoothedCushionMesh(SeatCushionEntity entity) {
    final forces = entity.forces;
    const rows = SeatCushionParameters.unitsMaxRow;
    const cols = SeatCushionParameters.unitsMaxColumn;
    const unitW = SeatCushionParameters.unitWidth;
    const unitH = SeatCushionParameters.unitHeight;
    const zScale = 0.01;

    double getForce(int r, int c) {
      if (r < 0 || r >= rows || c < 0 || c >= cols) return 0;
      return forces[r * cols + c].toDouble();
    }

    double avgForce(List<Point<int>> points) {
      if (points.isEmpty) return 0;
      return points.map((p) => getForce(p.x, p.y)).reduce((a, b) => a + b) / points.length;
    }

    final List<List<Sp3dV3D>> quads = [];

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        // 中心點位置
        final double centerX = (col - cols / 2) * unitW + unitW / 2;
        final double centerY = (row - rows / 2) * unitH + unitH / 2;

        // 四角 z 平滑值
        final ltZ = avgForce([
          Point(row, col),
          Point(row - 1, col),
          Point(row, col - 1),
          Point(row - 1, col - 1),
        ]) * zScale;

        final rtZ = avgForce([
          Point(row, col),
          Point(row - 1, col),
          Point(row, col + 1),
          Point(row - 1, col + 1),
        ]) * zScale;

        final lbZ = avgForce([
          Point(row, col),
          Point(row + 1, col),
          Point(row, col - 1),
          Point(row + 1, col - 1),
        ]) * zScale;

        final rbZ = avgForce([
          Point(row, col),
          Point(row + 1, col),
          Point(row, col + 1),
          Point(row + 1, col + 1),
        ]) * zScale;

        final basePoint = SeatCushionParameters.basePosition(type: entity.type);

        // 建立四點：lt, lb, rb, rt
        final lt = Sp3dV3D(basePoint.x + (centerX - unitW / 2), basePoint.y + (centerY - unitH / 2), (5 * ltZ));
        final lb = Sp3dV3D(basePoint.x + (centerX - unitW / 2), basePoint.y + (centerY + unitH / 2), (5 * lbZ));
        final rb = Sp3dV3D(basePoint.x + (centerX + unitW / 2), basePoint.y + (centerY + unitH / 2), (5 * rbZ));
        final rt = Sp3dV3D(basePoint.x + (centerX + unitW / 2), basePoint.y + (centerY - unitH / 2), (5 * rtZ));

        // quads.add([lt, lb, rb, rt]);
        quads.add([rt, rb, lb, lt]);
      }
    }

    return quads;
  }
  static Sp3dObj _sensorDataToObj(ThemeData theme, SeatCushionSensorData sensorData) {
    final tile = [
      ..._generateSmoothedCushionMesh(sensorData),
      ..._generateCushionBaseMesh(SeatCushionType.left),
      ..._generateCushionBaseMesh(SeatCushionType.right),
    ];
    List<Sp3dV3D> serialized = UtilSp3dList.serialize(tile);
    List<Sp3dFragment> fragments = [];
    int count = 0;
    for (List<Sp3dV3D> face in tile) {
      fragments.add(
        Sp3dFragment([Sp3dFace(UtilSp3dList.getIndexes(face, count * face.length), count)])
      );
      count++;
    }
    const rows = SeatCushionParameters.unitsMaxRow;
    const cols = SeatCushionParameters.unitsMaxColumn;
    final materials = sensorData.units.map((u) => Sp3dMaterial(
      _forceColor(force: u.force),
      true,
      1,
      _forceColor(force: u.force),
    )).followedBy(List.generate(
        rows * cols,
        (n) => Sp3dMaterial(
          theme.seatCushionUnitBorderColor,
          true,
          1.0,
          theme.seatCushionUnitBorderColor,
        )),
    ).followedBy(List.generate(
        rows * cols,
            (n) => Sp3dMaterial(
          theme.seatCushionUnitBorderColor,
          true,
          1.0,
          theme.seatCushionUnitBorderColor,
        )),
    ).toList(growable: false);
    return Sp3dObj(
      serialized,
      fragments,
      materials,
      [],
    );
  }
  _WorldChangeNotifier() {
  }
  Future<void> init(ThemeData theme, List<SeatCushionSensorData> sensorDataList) async {
    if(_isLoaded) return;
    for(final b in _buffers) {
      final d = sensorDataList.where((d) => d.type == b.type).lastOrNull;
      if(d == null) continue;
      b.obj = _sensorDataToObj(theme, d);
    }
    return _lock.synchronized(() async {
      _isLoaded = false;
      world = Sp3dWorld(_buffers
        .where((b) => b.obj != null)
        .map((b) => b.obj!)
        .toList()
      );
      final errorObjs = await world.initImages();
      _isLoaded = true;
      notifyListeners();
    });
  }
  Future<void> update(ThemeData theme, List<SeatCushionSensorData> sensorDataList) async {
    for(final b in _buffers) {
      final d = sensorDataList.where((d) => d.type == b.type).lastOrNull;
      if(d == null) continue;
      if(b.obj != null) world.remove(b.obj!);
      b.obj = _sensorDataToObj(theme, d);
      world.add(b.obj!, Sp3dV3D(0.0, 0.0, 0.0));
    }
    notifyListeners();
  }
}

class SeatCushion3dMeshWidget extends StatelessWidget {
  const SeatCushion3dMeshWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => SeatCushionSensorDataManagerChangeNotifier(
        seatCushionSensorDataStream: context.read<SeatCushionSensorDataStream>(),
      ),
      builder: (context, _) {
        final manager = context.read<SeatCushionSensorDataManagerChangeNotifier>();
        final sensorDataList = manager.dataList;
        return ChangeNotifierProxyProvider<SeatCushionSensorDataManagerChangeNotifier, _WorldChangeNotifier>(
          create: (_) => _WorldChangeNotifier()..init(theme, sensorDataList),
          update: (_, m, w) {
            final sensorDataList = m.dataList;
            if(w == null) return _WorldChangeNotifier()..init(theme, sensorDataList);
            return w..update(theme, sensorDataList);
          },
          builder: (context, _) {
            final w = context.watch<_WorldChangeNotifier>();
            final mediaQuery = MediaQuery.of(context);
            final world = w.world;
            final camera = w.camera;
            // bool prepareToMove = false;
            return Sp3dRenderer(
              useUserGesture: false,
              // onPanUpdate: (details) {
              //   // final dx = detail.localOffsetFromOrigin.dx;
              //   // final dy = detail.localOffsetFromOrigin.dy;
              //   // debugPrint("CCC: $prepareToMove");
              //   // if(!prepareToMove) return;
              //   final dx = details.diffV.x;
              //   final dy = details.diffV.y;
              //   debugPrint("CCC: $dx, $dy");
              //   camera.move(Sp3dV3D(camera.position.x + dx, camera.position.y + dy, camera.position.z));
              // },
              // onSecondPanDown: (details, obj) {
              //   debugPrint("onSecondPanDown");
              //   prepareToMove = true;
              // },
              // onPinchEnd: (details) {
              //   debugPrint("onPinchEnd");
              //   prepareToMove = false;
              // },
              allowUserWorldZoom: false,
              // pinchZoomSpeed: 1.0,
              // mouseZoomSpeed: 1.0,
              Size(mediaQuery.size.width, mediaQuery.size.height),
              Sp3dV2D(mediaQuery.size.width / 2, mediaQuery.size.height / 2),
              world,
              camera,
              Sp3dLight(Sp3dV3D(0, 0, -1), syncCam: true),
            );
          },
        );
      },
    );
  }
}
