import 'package:flutter/material.dart';
import 'package:utl_electrochemical_tester/domain/value/electrochemical_parameters.dart';

import '../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

class ElectrochemicalIcons {
  ElectrochemicalIcons._();
  static const ca = Icons.cabin;
  static const cv = Icons.calendar_view_day;
  static const dpv = Icons.dew_point;
  static Iterable<IconData> get typeIconData => ElectrochemicalType.values.map((type) {
    switch(type) {
      case ElectrochemicalType.ca:
        return ca;
      case ElectrochemicalType.cv:
        return cv;
      case ElectrochemicalType.dpv:
        return dpv;
    }
  });
  static const ampereIndex = Icons.indeterminate_check_box;
  static const ampereTime = Icons.timer;
  static const ampereVolt = Icons.volcano;
  static Iterable<IconData> get modeIconData => ElectrochemicalLineChartMode.values.map((type) {
    switch(type) {
      case ElectrochemicalLineChartMode.ampereIndex:
        return ampereIndex;
      case ElectrochemicalLineChartMode.ampereTime:
        return ampereTime;
      case ElectrochemicalLineChartMode.ampereVolt:
        return ampereVolt;
    }
  });
}
