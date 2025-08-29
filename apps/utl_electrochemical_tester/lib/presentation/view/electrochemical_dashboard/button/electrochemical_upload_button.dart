import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';

Future<void> showNoticeClearInfo({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      final appLocalizations = AppLocalizations.of(context)!;
      final notifier = context.read<ElectrochemicalFeatureChangeNotifier>();

      String title;
      if(appLocalizations.localeName == "zh") {
        title = "请选择上传方式";
      } else if(appLocalizations.localeName == "zh_TW") {
        title = "請選擇上傳方式";
      } else {
        title = "Please select upload method.";
      }

      UploadFileType selectedOption = UploadFileType.values.first;
      final content = StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: UploadFileType.values.map((v) => RadioListTile(
            title: Text(v.name),
            value: v.index,
            groupValue: selectedOption.index,
            onChanged: (int? value) {
              if(value == null) return;
              setState(() {
                selectedOption = UploadFileType.values[value];
              });
            },
          )).toList(growable: false),
        );
      });

      final clearCheckDialog = AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              notifier.uploadJsonFile(fileType: selectedOption);
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

class ElectrochemicalUploadButton extends StatelessWidget {
  const ElectrochemicalUploadButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalFeatureChangeNotifier>();
    final theme = Theme.of(context);
    return IconButton(
      onPressed: notifier.isUploading
          ? null
          : () => showNoticeClearInfo(context: context),
      icon: Icon(Icons.upload_file),
      color: theme.uploadEnabledColor,
    );
  }
}
