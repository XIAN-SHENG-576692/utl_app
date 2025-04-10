import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../domain/repository/electrochemical_entity_repository.dart';
import '../../../../presentation/change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';
import '../../../../service/file/file_handler.dart';

class ElectrochemicalFeatureChangeNotifierImpl extends ChangeNotifier implements ElectrochemicalFeatureChangeNotifier {
  final ElectrochemicalEntityRepository electrochemicalEntityRepository;
  final FileHandler fileHandler;
  final String folderPath;
  ElectrochemicalFeatureChangeNotifierImpl({
    required this.electrochemicalEntityRepository,
    required this.fileHandler,
    required this.folderPath,
  });

  bool _isClearingData = false;

  bool _isDownloadingFile = false;

  @override
  Future<bool> clearData() async {
    _isClearingData = true;
    notifyListeners();
    final result = await electrochemicalEntityRepository.clearRepository();
    _isClearingData = false;
    notifyListeners();
    return result;
  }

  @override
  Future<bool> downloadFile({required AppLocalizations appLocalizations}) async {
    _isDownloadingFile = true;
    notifyListeners();
    final result = await fileHandler.downloadAllElectrochemicalEntities(appLocalizations: appLocalizations, folderPath: folderPath);
    _isDownloadingFile = false;
    notifyListeners();
    return result;
  }

  @override
  bool get isClearingData => _isClearingData;

  @override
  bool get isDownloadingFile => _isDownloadingFile;
  
}