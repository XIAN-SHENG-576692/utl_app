import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../../domain/value/electrochemical_parameters.dart';
import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import '../../../widget/icons.dart';

class ElectrochemicalTypeShowButton extends Selector<ElectrochemicalLineChartChangeNotifier, bool> {
  ElectrochemicalTypeShowButton({
    super.key,
    required ElectrochemicalType type,
  }) : super(
    selector: (_, notifier) => notifier.getTypeShow(type: type),
    builder: (context, show, _) {
      final notifier = context.read<ElectrochemicalLineChartChangeNotifier>();
      final theme = Theme.of(context);
      final iconData = ElectrochemicalIcons.typeIconData.elementAt(type.index);
      Color? color = (show)
        ? theme.lineChartTypeEnabledColor
        : null;
      return IconButton(
        onPressed: () {
          notifier.setTypeShow(
            type: type,
            show: !show,
          );
        },
        icon: Icon(iconData),
        color: color,
      );
    },
  );
}
