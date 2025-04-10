import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_data.dart';
import '../../../change_notifier/seat_cushion_features.dart';
import '../../../widget/widget_resources.dart';

class _ClearingButton extends Selector<SeatCushionFeaturesChangeNotifier, bool> {
  _ClearingButton() : super(
    selector: (_, features) => features.isClearing,
    builder: (context, isClearing, _) {
      final appLocalizations = AppLocalizations.of(context)!;
      final themeData = Theme.of(context);
      final features = context.read<SeatCushionFeaturesChangeNotifier>();
      return IconButton(
        onPressed: (!isClearing)
          ? () async {
            await features.clear();
            await Fluttertoast.showToast(
              msg: appLocalizations.clearOldDataNotification,
            );
            return;
          }
          : null,
        icon: WidgetResources.clearOldDataIcon,
        color: themeData.clearOldDataButtonIconColor,
      );
    },
  );
}

class _IsSavingButton extends Selector<SeatCushionFeaturesChangeNotifier, bool> {
  _IsSavingButton() : super(
    selector: (_, features) => features.isSaving,
    builder: (context, isSaving, _) {
      final themeData = Theme.of(context);
      final features = context.read<SeatCushionFeaturesChangeNotifier>();
      return IconButton(
        onPressed: features.toggleIsSaving,
        icon: (!isSaving)
            ? WidgetResources.startSavingIcon
            : WidgetResources.endSavingIcon,
        color: (!isSaving)
            ? null
            : themeData.saveIconColor,
      );
    },
  );
}

class _DownloadFileButton extends Selector<SeatCushionFeaturesChangeNotifier, bool> {
  _DownloadFileButton() : super(
    selector: (_, features) => features.isDownloadingFile,
    builder: (context, isDownloadingFile, _) {
      final appLocalizations = AppLocalizations.of(context)!;
      final themeData = Theme.of(context);
      final features = context.read<SeatCushionFeaturesChangeNotifier>();
      return IconButton(
        onPressed: (!isDownloadingFile)
          ? () async {
            await features.downloadCsvFile(appLocalizations: appLocalizations);
            await Fluttertoast.showToast(
              msg: appLocalizations.downloadFileFinishedNotification("csv"),
            );
            return;
          }
          : null,
        icon: WidgetResources.downloadIcon,
        color: themeData.downloadIconColor,
      );
    },
  );
}

class SeatCushionButtonsBoard extends StatelessWidget {
  const SeatCushionButtonsBoard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ClearingButton(),
        Spacer(),
        _IsSavingButton(),
        _DownloadFileButton(),
      ],
    );
  }
}
