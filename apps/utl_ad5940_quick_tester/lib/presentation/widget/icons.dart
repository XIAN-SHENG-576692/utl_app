import 'package:flutter/material.dart';
import 'package:utl_ad5940_quick_tester/presentation/change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

class ElectrochemicalIcons {
  ElectrochemicalIcons._();
  static IconData getTypeIconData(ElectrochemicalLineChartType type) {
    switch(type) {
      case ElectrochemicalLineChartType.ca:
        return Icons.cabin;
      case ElectrochemicalLineChartType.cv:
        return Icons.calendar_view_day;
      case ElectrochemicalLineChartType.dpv:
        return Icons.dew_point;
      case ElectrochemicalLineChartType.eis0:
        return Icons.eight_k_sharp;
      case ElectrochemicalLineChartType.eis1:
        return Icons.eight_k_sharp;
    }
  }
}
