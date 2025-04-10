import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../application/seat_cushion_sensor_data_handler.dart';
import '../../domain/repository/seat_cushion_repository.dart';
import '../../service/file_handler.dart';

class SeatCushionFeaturesChangeNotifier extends ChangeNotifier {
  @protected
  final SeatCushionSensorDataHandler seatCushionSensorDataHandler;
  @protected
  final SeatCushionRepository seatCushionRepository;
  @protected
  final FileHandler fileHandler;
  late final StreamSubscription _isSavingSubscription;
  late final StreamSubscription _isClearingAllEntitiesSubscription;
  bool _isDownloadingFile = false;
  bool get isDownloadingFile => _isDownloadingFile;
  @protected
  set isDownloadingFile(bool isDownloadingFile) {
    if(_isDownloadingFile == isDownloadingFile) return;
    _isDownloadingFile = isDownloadingFile;
    notifyListeners();
  }
  SeatCushionFeaturesChangeNotifier({
    required this.fileHandler,
    required this.seatCushionSensorDataHandler,
    required this.seatCushionRepository,
  }) {
    _isSavingSubscription = seatCushionSensorDataHandler.isSavingStream.listen((_) {
      notifyListeners();
    });
    _isClearingAllEntitiesSubscription = seatCushionRepository.isClearingAllEntitiesStream.listen((_) {
      notifyListeners();
    });
  }
  set isSaving(bool isSaving) => seatCushionSensorDataHandler.isSaving = isSaving;
  void toggleIsSaving() {
    isSaving = !isSaving;
  }
  Future<bool> downloadCsvFile({
    required AppLocalizations appLocalizations,
  }) async {
    isDownloadingFile = true;
    final result = await fileHandler.downloadSeatCushionCsvFile(appLocalizations: appLocalizations);
    isDownloadingFile = false;
    return result;
  }
  bool get isSaving => seatCushionSensorDataHandler.isSaving;
  bool get isClearing => seatCushionRepository.isClearingAllEntities;
  Future<bool> clear() {
    return seatCushionRepository.clearAllEntities();
  }
  @override
  void dispose() {
    _isSavingSubscription.cancel();
    _isClearingAllEntitiesSubscription.cancel();
    super.dispose();
  }
}
