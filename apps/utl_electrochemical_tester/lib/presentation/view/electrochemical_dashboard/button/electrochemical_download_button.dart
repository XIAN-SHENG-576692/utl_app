import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';

class _FileObj {
  final DownloadFileType fileType;
  bool selected;
  _FileObj(this.fileType, this.selected);
}

Future<void> _showSelectionList({
  required BuildContext context,
  void Function(List<_FileObj> selectedOptions)? dialogOnPressed,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      final appLocalizations = AppLocalizations.of(context)!;

      String title;
      if(appLocalizations.localeName == "zh") {
        title = "选取下载格式";
      } else if(appLocalizations.localeName == "zh_TW") {
        title = "選取下載格式";
      } else {
        title = "Select the file format";
      }

      final selectedOptions = DownloadFileType.values.map((f) => _FileObj(f, false)).toList(growable: false);
      final content = Column(
        mainAxisSize: MainAxisSize.min,
        children: selectedOptions.map((v) => StatefulBuilder(builder: (context, setState) {
          return CheckboxListTile(
            value: v.selected,
            onChanged: (b) {
              setState(() {
                selectedOptions[v.fileType.index].selected = b ?? false;
              });
            },
            title: Text(v.fileType.name),
          );
        })).toList(growable: false),
      );

      final clearCheckDialog = AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              dialogOnPressed?.call(selectedOptions);
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

class ElectrochemicalDownloadButton extends StatelessWidget {
  const ElectrochemicalDownloadButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalFeatureChangeNotifier>();
    final fileTypes = context.select<ElectrochemicalFeatureChangeNotifier, List<DownloadFileTypeObj>>((n) => n.fileTypes);
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    VoidCallback? onPressed = (fileTypes.where((f) => f.isDownloading == true).isEmpty)
      ? () => _showSelectionList(
        context: context,
        dialogOnPressed: (selectedOptions) async {
          for(final f in selectedOptions.where((s) => s.selected).map((s) => s.fileType)) {
            await notifier.downloadFile(appLocalizations: appLocalizations, fileTypes: [f]);
            Fluttertoast.showToast(
              msg: appLocalizations.downloadFileFinishedNotification(f.name),
            );
          }
        },
      )
      : null;
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.save),
      color: theme.downloadEnabledColor,
    );
  }
}
