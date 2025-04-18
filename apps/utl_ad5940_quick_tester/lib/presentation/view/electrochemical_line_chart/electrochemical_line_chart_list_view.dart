import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_ad5940_quick_tester/presentation/view/electrochemical_line_chart/electrochemical_line_chart_view.dart';

import '../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import '../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_manager_change_notifier.dart';

class ElectrochemicalLineChartListView extends StatelessWidget {
  const ElectrochemicalLineChartListView({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = context.read<ElectrochemicalLineChartManagerChangeNotifier>();
    return ChangeNotifierProxyProvider<ElectrochemicalLineChartManagerChangeNotifier, ElectrochemicalLineChartChangeNotifier>(
      create: (_) => ElectrochemicalLineChartChangeNotifier(x: null, manager: manager, type: manager.typeShow),
      update: (BuildContext context, manager, ElectrochemicalLineChartChangeNotifier? previous) => ElectrochemicalLineChartChangeNotifier(x: previous?.x, manager: manager, type: manager.typeShow),
      child: ElectrochemicalLineChartView(),
    );
  }
}
