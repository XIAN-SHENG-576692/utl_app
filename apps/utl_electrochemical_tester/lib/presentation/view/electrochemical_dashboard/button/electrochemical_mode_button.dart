import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import '../../../widget/icons.dart';

class ElectrochemicalModeButton extends Selector<ElectrochemicalLineChartChangeNotifier, ElectrochemicalLineChartMode> {
  ElectrochemicalModeButton({
    super.key,
    required ElectrochemicalLineChartMode mode,
  }) : super(
    selector: (_, notifier) => notifier.mode,
    builder: (context, selectedMode, _) {
      final notifier = context.read<ElectrochemicalLineChartChangeNotifier>();
      final theme = Theme.of(context);
      final iconData = ElectrochemicalIcons.modeIconData.elementAt(mode.index);
      Color? color = (mode == selectedMode)
        ? theme.lineChartModeEnabledColor
        : null;
      return IconButton(
        onPressed: () {
          notifier.mode = mode;
        },
        icon: Icon(iconData),
        color: color,
      );
    },
  );
}
