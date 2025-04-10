import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';

class ElectrochemicalDownloadButton extends Selector<ElectrochemicalFeatureChangeNotifier, bool> {
  ElectrochemicalDownloadButton({
    super.key,
  }) : super(
    selector: (_, notifier) => notifier.isDownloadingFile,
    builder: (context, isDownloadingFile, _) {
      final notifier = context.read<ElectrochemicalFeatureChangeNotifier>();
      final appLocalizations = AppLocalizations.of(context)!;
      final theme = Theme.of(context);
      VoidCallback? onPressed = (!isDownloadingFile)
        ? () async {
          bool isCompleted = await notifier.downloadFile(appLocalizations: appLocalizations);
          if(isCompleted) {
            Fluttertoast.showToast(
              msg: appLocalizations.downloadFileFinishedNotification(
                  "csv"),
            );
          }
        }
        : null;
      return IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.save),
        color: theme.downloadEnabledColor,
      );
    },
  );
}
