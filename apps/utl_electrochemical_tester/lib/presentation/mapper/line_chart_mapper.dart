import 'dart:math';

import 'package:common_utils/double.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/entity/electrochemical_entity.dart';
import '../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import 'colors_mapper.dart';

class LineChartMapper {
  LineChartMapper._();
  static Iterable<double> getXList({
    required ElectrochemicalLineChartMode mode,
    required ElectrochemicalHeader header,
  }) {
    switch(mode) {
      case ElectrochemicalLineChartMode.ca:
        return header.type == ElectrochemicalType.ca
            ? header.caParameters!.times
            : Iterable.empty();
      case ElectrochemicalLineChartMode.cv:
        return header.type == ElectrochemicalType.cv
            ? header.cvParameters!.voltages
            : Iterable.empty();
      case ElectrochemicalLineChartMode.dpv:
        return header.type == ElectrochemicalType.dpv
            ? header.dpvParameters!.baseVoltages
            : Iterable.empty();
      case ElectrochemicalLineChartMode.eis0:
        // TODO: Handle this case.
        return Iterable.empty();
      case ElectrochemicalLineChartMode.eis1:
        // TODO: Handle this case.
        return Iterable.empty();
    }
  }
  static Iterable<double> getYList({
    required ElectrochemicalLineChartMode mode,
    required ElectrochemicalEntity entity,
  }) {
    switch(mode) {
      case ElectrochemicalLineChartMode.ca:
        return entity.header.type == ElectrochemicalType.ca
            ? entity.currents.map((c) => (c * 1e9).toPrecision(6))
            : Iterable.empty();
      case ElectrochemicalLineChartMode.cv:
        return entity.header.type == ElectrochemicalType.cv
            ? entity.currents.map((c) => (c * 1e9).toPrecision(6))
            : Iterable.empty();
      case ElectrochemicalLineChartMode.dpv:
        return entity.header.type == ElectrochemicalType.dpv
            ? entity.dvpCurrents.map((c) => (c * 1e9).toPrecision(6))
            : Iterable.empty();
      case ElectrochemicalLineChartMode.eis0:
      // TODO: Handle this case.
        return Iterable.empty();
      case ElectrochemicalLineChartMode.eis1:
      // TODO: Handle this case.
        return Iterable.empty();
    }
  }
  static Iterable<Point<double>> getPoints({
    required ElectrochemicalLineChartMode mode,
    required ElectrochemicalEntity entity,
  }) {
    final xList = getXList(mode: mode, header: entity.header).toList(growable: false);
    final yList = getYList(mode: mode, entity: entity).toList(growable: false);
    return Iterable.generate(min(xList.length, yList.length), (n) => Point(xList.skip(n).first, yList.skip(n).first));
  }
  static List<LineSeries<Point<double>, double>> mapElectrochemicalEntitiesToLineChartSeriesList({
    required Iterable<ElectrochemicalEntity> entities,
    required ElectrochemicalLineChartMode mode,
  }) {
    return entities
        .indexed.map((element) {
      int length = entities.length;
      int index = element.$1;
      var entity = element.$2;
      return LineSeries<Point<double>, double>(
        name: entity.header.dataName,
        dataSource: getPoints(mode: mode, entity: entity).toList(growable: false),
        animationDuration: 0,
        xValueMapper: (Point<double> data, _) => data.x,
        yValueMapper: (Point<double> data, _) => data.y,
        color: ColorsMapper.mapElectrochemicalEntitiesToColor(
          index: index,
          length: length,
        ),
        width: 1.5,
        // markerSettings: MarkerSettings(isVisible: true),
      );
    }).toList();
  }
}
