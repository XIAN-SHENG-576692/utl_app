import 'dart:async';

import '../domain/entity/electrochemical_entity.dart';
import '../domain/value/electrochemical_data.dart';
import '../domain/value/electrochemical_parameters.dart';
import '../l10n/generated/app_localizations.dart';
import '../service/data_stream/electrochemical_data_stream.dart';
import '../service/file/all_entities_file.dart';
import '../service/file/ca_entity_file.dart';
import '../service/file/cv_entity_file.dart';
import '../service/file/dpv_detail_entity_file.dart';
import '../service/file/dpv_entity_file.dart';

class BufferAndDownloadFile {
  late final StreamSubscription<IdWithHeader> _headerSubscription;
  late final StreamSubscription<ElectrochemicalData> _dataSubscription;
  late final StreamSubscription<void> _endSubscription;
  final StreamController<ElectrochemicalEntity?> _entityUpsertController = StreamController.broadcast();
  Stream<ElectrochemicalEntity?> get entityUpsertStream => _entityUpsertController.stream;
  ElectrochemicalEntity? entity;
  final AllEntitiesFile allEntitiesFile;
  final String folderPath;
  BufferAndDownloadFile({
    required ElectrochemicalDataStream electrochemicalDataStream,
    required this.folderPath,
  })
    : allEntitiesFile = AllEntitiesFile(folderPath: folderPath)
  {
    _headerSubscription = electrochemicalDataStream.headerStream.listen((header) {
      entity = ElectrochemicalEntity(
        id: header.id,
        header: header.header,
        data: [],
      );
      _entityUpsertController.add(entity);
    });
    _dataSubscription = electrochemicalDataStream.dataStream.listen((data) {
      entity?.data.add(data);
      _entityUpsertController.add(entity);
    });
    _endSubscription = electrochemicalDataStream.endStream.listen((_) {
      if(entity == null) return;
      allEntitiesFile.downloadAllElectrochemicalEntity(
        dataName: dataName,
        entity: entity!,
        folderPath: folderPath,
      );
      switch(entity?.header.type) {
        case null:
          break;
        case ElectrochemicalType.ca:
          CaEntityFile(dataName: dataName, entity: entity!, folderPath: folderPath);
          break;
        case ElectrochemicalType.cv:
          CvEntityFile(dataName: dataName, entity: entity!, folderPath: folderPath);
          break;
        case ElectrochemicalType.dpv:
          DpvEntityFile(dataName: dataName, entity: entity!, folderPath: folderPath);
          DpvDetailEntityFile(dataName: dataName, entity: entity!, folderPath: folderPath);
          break;
      }
      _entityUpsertController.add(entity);
      entity = null;
    });
  }
  String dataName = "";
  void close() {
    _headerSubscription.cancel();
    _dataSubscription.cancel();
    _endSubscription.cancel();
    _entityUpsertController.close();
  }
}