import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../presentation/theme/theme_data.dart';
import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_manager_change_notifier.dart';
import '../../../widget/icons.dart';

class ElectrochemicalTypeShowButton extends Selector<ElectrochemicalLineChartManagerChangeNotifier, bool> {
  ElectrochemicalTypeShowButton({
    super.key,
    required ElectrochemicalLineChartType type,
  }) : super(
    selector: (_, manager) => manager.typeShow == type,
    builder: (context, show, _) {
      final notifier = context.read<ElectrochemicalLineChartManagerChangeNotifier>();
      final theme = Theme.of(context);
      final iconData = ElectrochemicalIcons.getTypeIconData(type);
      Color? color = (show)
        ? theme.lineChartTypeEnabledColor
        : null;
      return IconButton(
        onPressed: () {
          notifier.selectTypeShow(type);
        },
        icon: Icon(iconData),
        color: color,
      );
    },
  );
}
