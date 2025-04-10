import 'package:flutter/widgets.dart' show ChangeNotifier;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class ElectrochemicalFeatureChangeNotifier implements ChangeNotifier {
  bool get isDownloadingFile;
  Future<bool> downloadFile({
    required AppLocalizations appLocalizations,
  });
  bool get isClearingData;
  Future<bool> clearData();
}
