import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';

Future<void> showNoticeClearInfo({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (_) {
      final appLocalizations = AppLocalizations.of(context)!;
      final notifier = context.read<ElectrochemicalFeatureChangeNotifier>();
      dialogOnPressed() => notifier.clearData();

      String title;
      if(appLocalizations.localeName == "zh") {
        title = "警告: 清除资料";
      } else if(appLocalizations.localeName == "zh_TW") {
        title = "警告: 清除資料";
      } else {
        title = "Caution: clear all data.";
      }

      String content;
      if(appLocalizations.localeName == "zh") {
        content = "您确定要清除所有资料?";
      } else if(appLocalizations.localeName == "zh_TW") {
        content = "您確定要清除所有資料?";
      } else {
        content = "Are you sure you want to clear all data?";
      }

      final clearCheckDialog = AlertDialog(
        title: Text(title),
        content: Text(content),
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
