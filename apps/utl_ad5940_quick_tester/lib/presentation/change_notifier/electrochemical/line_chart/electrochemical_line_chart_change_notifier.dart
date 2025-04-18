import 'dart:math';

import 'package:common_utils/dataset_color_generator.dart';
import 'package:flutter/widgets.dart';
import 'package:line_chart_utils/line_chart_change_notifier.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:utl_ad5940_quick_tester/domain/value/electrochemical_parameters.dart';

import '../../../../domain/entity/electrochemical_entity.dart';
import 'electrochemical_line_chart_manager_change_notifier.dart';

enum ElectrochemicalLineChartType {
  ca,
  cv,
  dpv,
  eis0,
  eis1,
}

class ElectrochemicalLineChartChangeNotifier extends LineChartChangeNotifier {
  ElectrochemicalLineChartManagerChangeNotifier manager;
  @protected
  ElectrochemicalLineChartType type;
  Iterable<ElectrochemicalEntity> get _entities => manager.entities.where((entity) {
    switch(type) {
      case ElectrochemicalLineChartType.ca:
        return entity.header.type == ElectrochemicalType.ca;
      case ElectrochemicalLineChartType.cv:
        return entity.header.type == ElectrochemicalType.cv;
      case ElectrochemicalLineChartType.dpv:
        return entity.header.type == ElectrochemicalType.dpv;
      case ElectrochemicalLineChartType.eis0:
      // TODO: Handle this case.
        return false;
      case ElectrochemicalLineChartType.eis1:
      // TODO: Handle this case.
        return false;
    }
  });
  Iterable<Point<double>> getDataSource(ElectrochemicalEntity entity) {
    switch(type) {
      case ElectrochemicalLineChartType.ca:
        final times = entity.header.caParameters!.times;
        final currents = entity.header.caParameters!.currents(
          adcData: entity.data.map((d) => d.adcData),
          adcPga: entity.header.adcPga,
          vRef1p82: entity.header.vRef1p82,
          hsRTia: entity.header.hsRTia,
        );
        return Iterable.generate(min(times.length, currents.length), (i) {
          return Point<double>(times.skip(i).first, currents.skip(i).first);
        });
      case ElectrochemicalLineChartType.cv:
        final voltages = entity.header.cvParameters!.voltages;
        final currents = entity.header.cvParameters!.currents(
          adcData: entity.data.map((d) => d.adcData),
          adcPga: entity.header.adcPga,
          vRef1p82: entity.header.vRef1p82,
          hsRTia: entity.header.hsRTia,
        );
        return Iterable.generate(min(voltages.length, currents.length), (i) {
          return Point<double>(voltages.skip(i).first, currents.skip(i).first);
        });
      case ElectrochemicalLineChartType.dpv:
        final voltages = entity.header.dpvParameters!.voltages;
        final dpvCurrents = entity.header.dpvParameters!.currents(
          adcData: entity.data.map((d) => d.adcData),
          adcPga: entity.header.adcPga,
          vRef1p82: entity.header.vRef1p82,
          hsRTia: entity.header.hsRTia,
        );
        return Iterable.generate(min(voltages.length, dpvCurrents.length), (i) {
          return Point<double>(voltages.skip(i).first, dpvCurrents.skip(i).first);
        });
      case ElectrochemicalLineChartType.eis0:
        // TODO: Handle this case.
        return [];
      case ElectrochemicalLineChartType.eis1:
        // TODO: Handle this case.
        return [];
    }
  }
  List<LineSeries<Point<double>, double>> createLineSeriesList() {
    final length = _entities.length;
    return _entities.indexed
      .map((entry) {
        final index = entry.$1;
        final entity = entry.$2;
        final time = entity.header.createdTime;
        return LineSeries<Point<double>, double>(
          name: "${time.hour.toString().padLeft(2, "0")}-${time.minute.toString().padLeft(2, "0")}-${time.second.toString().padLeft(2, "0")}",
          dataSource: getDataSource(entity).toList(growable: false),
          xValueMapper: (Point<double> datum, int index) => datum.x,
          yValueMapper: (Point<double> datum, int index) => datum.y,
          animationDuration: 0,
          color: DatasetColorGenerator.rainbowGroup(
            alpha: 1.0,
            index: index + 10,
            length: length,
            groupIndex: type.index,
            groupLength: ElectrochemicalLineChartType.values.length,
          ),
          width: 1.5,
        );
      })
      .toList(growable: false);
  }
  ElectrochemicalLineChartChangeNotifier({
    required super.x,
    required this.manager,
    required this.type,
  }) {
    manager.addListener(notifyListeners);
  }
  @override
  void dispose() {
    manager.removeListener(notifyListeners);
    super.dispose();
  }
}
