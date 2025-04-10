import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';

void showNoticeClearInfo({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (_) {
      final appLocalizations = AppLocalizations.of(context)!;
      final notifier = context.read<ElectrochemicalFeatureChangeNotifier>();
      dialogOnPressed() => notifier.clearData();
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

class ElectrochemicalClearButton extends Selector<ElectrochemicalFeatureChangeNotifier, bool> {
  ElectrochemicalClearButton({
    super.key,
  }) : super(
    selector: (_, notifier) => notifier.isClearingData,
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
