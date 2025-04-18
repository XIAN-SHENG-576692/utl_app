import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class FileHandler {
  Future<bool> downloadAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  });
}