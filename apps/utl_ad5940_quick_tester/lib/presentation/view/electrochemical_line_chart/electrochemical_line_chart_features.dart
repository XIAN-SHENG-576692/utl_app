import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_ad5940_quick_tester/presentation/theme/theme_data.dart';
import 'package:utl_ad5940_quick_tester/presentation/view/electrochemical_line_chart/button/electrochemical_clear_button.dart';
import 'package:utl_ad5940_quick_tester/presentation/view/electrochemical_line_chart/button/electrochemical_type_show_button.dart';

import '../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import '../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_manager_change_notifier.dart';
import '../../widget/icons.dart';

class ElectrochemicalLineChartFeatures extends StatelessWidget {
  const ElectrochemicalLineChartFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalLineChartManagerChangeNotifier>();
    return Row(
      children: [
        ...ElectrochemicalLineChartType.values.map((type) {
          return ElectrochemicalTypeShowButton(type: type);
        }),
        Spacer(),
        ElectrochemicalClearButton(),
      ],
    );
  }
}
