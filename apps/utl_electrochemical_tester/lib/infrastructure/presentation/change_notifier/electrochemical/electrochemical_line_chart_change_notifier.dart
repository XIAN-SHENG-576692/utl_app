import 'dart:async';
import 'dart:math';

import 'package:common_utils/dataset_color_generator.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:utl_electrochemical_tester/domain/value/electrochemical_parameters.dart';

import '../../../../domain/entity/electrochemical_entity.dart';
import '../../../../domain/repository/electrochemical_entity_repository.dart';
import '../../../../domain/usecase/process_electrochemical_entities_usecase.dart';
import '../../../../presentation/change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

part 'mapper.dart';

class _TypeShow {
  ElectrochemicalType type;
  bool show;
  _TypeShow({
    required this.type,
    required this.show,
  });
}

class ElectrochemicalLineChartChangeNotifierImpl extends ChangeNotifier implements ElectrochemicalLineChartChangeNotifier {
  final ElectrochemicalEntityRepository electrochemicalEntityRepository;
  final List<ElectrochemicalEntity> electrochemicalEntityBuffers = [];
  List<LineSeries<Point<double>, double>> _lineSeriesList = [];
  List<ElectrochemicalLineChartDetail> _details = [];
  late final StreamSubscription _syncStreamSubscription;
  late final StreamSubscription _removedStreamSubscription;
  void updateData() {
    updateDetails();
    _lineSeriesList = _Mapper.mapElectrochemicalEntitiesToLineChartSeriesList(
      entities: electrochemicalEntityBuffers
          .where((e) => _typeShows.elementAt(e.electrochemicalHeader.type.index).show),
      mode: mode,
    ).toList(growable: false);
  }
  void updateDetails() {
    _details = _Mapper.mapElectrochemicalEntitiesToLineChartDetails(
      entities: electrochemicalEntityBuffers
          .where((e) => _typeShows.elementAt(e.electrochemicalHeader.type.index).show),
      x: (x != null)
        ? _Mapper.mapLineChartXToRealX(
          lineChartX: x!,
          mode: mode,
        )
        : null,
      mode: mode,
    ).toList(growable: false);
  }
  ElectrochemicalLineChartChangeNotifierImpl({
    required this.electrochemicalEntityRepository,
  }) {
    var processElectrochemicalEntitiesUsecase = ProcessElectrochemicalEntitiesUsecase(
        electrochemicalEntityRepository: electrochemicalEntityRepository
    );

    processElectrochemicalEntitiesUsecase(
      processor: (entity) {
        if(entity == null) return true;
        electrochemicalEntityBuffers.add(entity);
        updateData();
        notifyListeners();
        return true;
      },
    );

    _syncStreamSubscription = electrochemicalEntityRepository.entitySyncStream.listen((entity) {
      int index = electrochemicalEntityBuffers.indexOf(entity);
      index != -1
        ? electrochemicalEntityBuffers[index] = entity
        : electrochemicalEntityBuffers.add(entity);
      updateData();
      notifyListeners();
    });

    _removedStreamSubscription = electrochemicalEntityRepository.entityRemovedStream.listen((entityId) {
      electrochemicalEntityBuffers.removeWhere((entity) => entity.id == entityId);
      updateData();
      notifyListeners();
    });
  }

  @override
  ElectrochemicalLineChartFilter filter = ElectrochemicalLineChartFilter();

  ElectrochemicalLineChartMode _mode = ElectrochemicalLineChartMode.ampereIndex;
  @override
  ElectrochemicalLineChartMode get mode => _mode;
  @override
  set mode(ElectrochemicalLineChartMode newMode) {
    if(_mode == newMode) return;
    _mode = newMode;
    _lineChartX = null;
    updateData();
    notifyListeners();
  }

  @override
  List<ElectrochemicalLineChartDetail> get details => _details;

  @override
  void dispose() {
    _syncStreamSubscription.cancel();
    _removedStreamSubscription.cancel();
    super.dispose();
  }

  @override
  bool getTypeShow({required ElectrochemicalType type}) {
    return _typeShows.firstWhere((t) => t.type == type).show;
  }

  @override
  List<LineSeries<Point<double>, double>> get lineSeriesList => _lineSeriesList;

  final List<_TypeShow> _typeShows = ElectrochemicalType
      .values
      .map((type) => _TypeShow(type: type, show: true))
      .toList();
  @override
  void setTypeShow({required ElectrochemicalType type, required bool show}) {
    final t = _typeShows.firstWhere((t) => t.type == type);
    if(t.show == show) return;
    t.show = show;
    updateData();
    notifyListeners();
  }
  @override
  void toggleTypeShow({
    required ElectrochemicalType type,
  }) {
    final t = _typeShows.firstWhere((t) => t.type == type);
    t.show = !t.show;
    updateData();
    notifyListeners();
  }

  double? _lineChartX;
  @override
  double? get x => _lineChartX;
  @override
  set x(double? newX) {
    if(_lineChartX == newX) return;
    _lineChartX = newX;
    updateDetails();
    notifyListeners();
  }

  bool _isTouched = false;
  @override
  set isTouched(bool newIsTouched) {
    if(_isTouched == newIsTouched) return;
    _isTouched = newIsTouched;
    notifyListeners();
  }

}
