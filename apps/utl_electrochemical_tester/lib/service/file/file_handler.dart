import '../../l10n/gen_l10n/app_localizations.dart';

abstract class FileHandler {
  Future<bool> downloadCsvRowAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  });
  Future<bool> downloadCsvLineChartAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  });
  Future<bool> downloadCsvDpvLineChartAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  });
  Future<bool> downloadJsonAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  });
}