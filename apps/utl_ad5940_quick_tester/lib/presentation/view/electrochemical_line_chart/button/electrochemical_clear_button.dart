import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_ad5940_quick_tester/presentation/theme/theme_data.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_manager_change_notifier.dart';

void showNoticeClearInfo({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (_) {
      final appLocalizations = AppLocalizations.of(context)!;
      final notifier = context.read<ElectrochemicalLineChartManagerChangeNotifier>();
      dialogOnPressed() => notifier.clearSeries();
      final clearCheckDialog = AlertDialog(
        title: Text(appLocalizations.clearAllDataTitle),
        content: Text(appLocalizations.areYouSureYouWantToClearAllDataMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              dialogOnPressed();
            },
            child: Text(appLocalizations.yesButtonText),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 在這裡執行確認後的操作
            },
            child: Text(appLocalizations.noButtonText),
          ),
        ],
      );
      return clearCheckDialog;
    },
  );
}

class ElectrochemicalClearButton extends Selector<ElectrochemicalLineChartManagerChangeNotifier, bool> {
  ElectrochemicalClearButton({
    super.key,
  }) : super(
    selector: (_, notifier) => false,
    builder: (context, isClearingData, _) {
      final theme = Theme.of(context);
      VoidCallback? onPressed = (!isClearingData)
        ? () => showNoticeClearInfo(
          context: context,
        )
        : null;
      return IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.delete),
        color: theme.clearEnabledColor,
      );
    },
  );
}
