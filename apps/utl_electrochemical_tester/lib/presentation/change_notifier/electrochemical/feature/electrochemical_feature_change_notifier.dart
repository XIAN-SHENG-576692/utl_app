import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:synchronized/synchronized.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';

import '../../../../domain/repository/electrochemical_entity_repository.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../../service/file/file_handler.dart';

enum DownloadFileType {
  csvRow,
  csvLineChart,
  csvDpvLineChart,
  json,
}

class DownloadFileTypeObj extends Equatable {
  final DownloadFileType fileType;
  final bool isDownloading;
  const DownloadFileTypeObj(this.fileType, this.isDownloading);
  @override
  List<Object?> get props => [
    fileType,
    isDownloading,
  ];
}

enum UploadFileType {
  jsonAppend,
  jsonOverwrite,
}

class ElectrochemicalFeatureChangeNotifier extends ChangeNotifier {
  @protected
  final String folderPath;
  @protected
  final FileHandler fileHandler;
  @protected
  final ElectrochemicalEntityRepository electrochemicalEntityRepository;
  ElectrochemicalFeatureChangeNotifier({
    required this.electrochemicalEntityRepository,
    required this.folderPath,
    required this.fileHandler,
  });
  final Lock _lock = Lock();

  List<DownloadFileTypeObj> fileTypes = DownloadFileType.values.map((t) => DownloadFileTypeObj(t, false)).toList(growable: false);
  Future<bool> downloadFile({
    required AppLocalizations appLocalizations,
    required Iterable<DownloadFileType> fileTypes,
  }) async {
    return _lock.synchronized(() async {
      for(final t in fileTypes) {
        this.fileTypes[t.index] = DownloadFileTypeObj(t, true);
        notifyListeners();
        bool result;
        switch(t) {
          case DownloadFileType.csvRow:
            result = await fileHandler.downloadCsvRowAllElectrochemicalEntities(
              appLocalizations: appLocalizations,
              folderPath: folderPath,
            );
          case DownloadFileType.csvLineChart:
            result = await fileHandler.downloadCsvLineChartAllElectrochemicalEntities(
              appLocalizations: appLocalizations,
              folderPath: folderPath,
            );
          case DownloadFileType.csvDpvLineChart:
            result = await fileHandler.downloadCsvDpvLineChartAllElectrochemicalEntities(
              appLocalizations: appLocalizations,
              folderPath: folderPath,
            );
          case DownloadFileType.json:
            result = await fileHandler.downloadJsonAllElectrochemicalEntities(
              appLocalizations: appLocalizations,
              folderPath: folderPath,
            );
        }
        this.fileTypes[t.index] = DownloadFileTypeObj(t, false);
        notifyListeners();
        if(!result) return result;
      }
      return true;
    });
  }

  bool _isUploading = false;
  bool get isUploading => _isUploading;
  void uploadJsonFile({
    required UploadFileType fileType,
  }) async {
    _isUploading = true;
    notifyListeners();
    FilePickerResult? res = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    try {
      for(final f in res!.files) {
        File file = File(f.path!);
        String content = await file.readAsString();
        for(final entity in content.jsonDecode()) {
          switch(fileType) {
            case UploadFileType.jsonAppend:
              await electrochemicalEntityRepository.createEntityFromHeader(header: entity.header, data: entity.data);
              break;
            case UploadFileType.jsonOverwrite:
              await electrochemicalEntityRepository.upsertEntity(entity: entity);
              break;
          }
        }
      }
    } catch(e) {}
    _isUploading = false;
    notifyListeners();
  }

  bool _isClearingData = false;
  bool get isClearingData => _isClearingData;
  Future<bool> clearData() async {
    return _lock.synchronized(() async {
      _isClearingData = true;
      notifyListeners();
      final result = await electrochemicalEntityRepository.clearRepository();
      _isClearingData = false;
      notifyListeners();
      return result;
    });
  }
}
