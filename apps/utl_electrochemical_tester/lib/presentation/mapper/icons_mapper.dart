import 'package:flutter/material.dart';

import '../../domain/entity/electrochemical_entity.dart';
import '../../fonts/electrochemical_icon_data_icons.dart';
import '../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

class IconsMapper {
  IconsMapper._();
  static IconData mapElectrochemicalTypeToIconData(ElectrochemicalType type) {
    switch(type) {
      case ElectrochemicalType.ca:
        return ElectrochemicalIconData.ca;
      case ElectrochemicalType.cv:
        return ElectrochemicalIconData.cv;
      case ElectrochemicalType.dpv:
        return ElectrochemicalIconData.dpv;
    }
  }
  static IconData mapElectrochemicalLineChartModeToIconData(ElectrochemicalLineChartMode mode) {
    switch(mode) {
      case ElectrochemicalLineChartMode.ca:
        return ElectrochemicalIconData.ca;
      case ElectrochemicalLineChartMode.cv:
        return ElectrochemicalIconData.cv;
      case ElectrochemicalLineChartMode.dpv:
        return ElectrochemicalIconData.dpv;
      case ElectrochemicalLineChartMode.eis0:
        return ElectrochemicalIconData.eis0;
      case ElectrochemicalLineChartMode.eis1:
        return ElectrochemicalIconData.eis1;
    }
  }
}
