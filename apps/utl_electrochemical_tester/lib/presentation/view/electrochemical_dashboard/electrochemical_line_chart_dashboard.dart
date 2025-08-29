import 'package:flutter/material.dart';

import '../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import 'button/electrochemical_clear_button.dart';
import 'button/electrochemical_download_button.dart';
import 'button/electrochemical_mode_button.dart';
import 'button/electrochemical_upload_button.dart';
import 'detail/electrochemical_line_chart_details_view.dart';

class ElectrochemicalLineChartDashboard extends StatelessWidget {
  const ElectrochemicalLineChartDashboard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final lineChartInfoView = ElectrochemicalLineChartDetailsView();
    final toolButtons = [
      ElectrochemicalUploadButton(),
      ElectrochemicalDownloadButton(),
      ElectrochemicalClearButton(),
    ];
    final lineChartModeButtons = ElectrochemicalLineChartMode.values.map((mode) => ElectrochemicalModeButton(mode: mode)).toList();
    final buttonsBoard = [
      [
        ...toolButtons,
        Spacer(),
        ...lineChartModeButtons,
      ],
    ];
    final view = Column(
      children: [
        ...buttonsBoard.map((b) => Row(
          children: [
            ...b,
          ],
        )),
        Divider(),
        Expanded(
          child: lineChartInfoView,
        ),
      ],
    );
    return view;
  }
}
