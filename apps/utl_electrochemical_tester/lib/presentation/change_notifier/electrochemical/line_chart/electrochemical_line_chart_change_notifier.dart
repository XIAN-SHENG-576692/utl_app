import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart' show LineSeries;
import 'package:utl_electrochemical_tester/domain/value/electrochemical_parameters.dart';

part 'detail.dart';
part 'filter.dart';

enum ElectrochemicalLineChartMode {
  ampereIndex,
  ampereTime,
  ampereVolt,
}

abstract class ElectrochemicalLineChartChangeNotifier implements ChangeNotifier {
  ElectrochemicalLineChartMode get mode;
  set mode(ElectrochemicalLineChartMode newMode);

  void setTypeShow({
    required ElectrochemicalType type,
    required bool show,
  });
  void toggleTypeShow({
    required ElectrochemicalType type,
  });
  bool getTypeShow({
    required ElectrochemicalType type,
  });

  ElectrochemicalLineChartFilter get filter;
  set filter(ElectrochemicalLineChartFilter newFilter);

  List<LineSeries<Point<double>, double>> get lineSeriesList;

  set isTouched(bool newIsTouched);

  set x(double? newX);
  double? get x;

  List<ElectrochemicalLineChartDetail> get details;
}
