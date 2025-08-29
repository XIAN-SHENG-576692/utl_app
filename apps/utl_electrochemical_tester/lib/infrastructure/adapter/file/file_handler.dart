import 'package:flutter/cupertino.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/domain/repository/electrochemical_entity_repository.dart';
import 'package:utl_electrochemical_tester/domain/usecase/process_electrochemical_entities_usecase.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/csv_file/csv_dpv_line_chart_electrochemical_file.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/csv_file/csv_line_chart_electrochemical_file.dart';

import '../../../l10n/gen_l10n/app_localizations.dart';
import '../../../service/file/file_handler.dart';
import '../../source/csv_file/csv_row_electrochemical_file.dart';
import '../../source/json_file/json_electrochemical_file.dart';

class FileHandlerImpl implements FileHandler {
  ElectrochemicalEntityRepository electrochemicalEntityRepository;
  FileHandlerImpl({
    required this.electrochemicalEntityRepository,
  });
  @override
  Future<bool> downloadCsvRowAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  }) async {
    var usecase = ProcessElectrochemicalEntitiesUsecase(
      electrochemicalEntityRepository: electrochemicalEntityRepository,
    );
    final file = CsvRowElectrochemicalFile(folderPath: folderPath);
    if(!(await file.clearThenGenerateHeader(appLocalizations: appLocalizations))) return false;
    bool flag = true;
    usecase(
      processor: (entity) {
        debugPrint("downloadAllElectrochemicalEntities: $entity");
        if(entity == null) return true;
        file.writeEntities(
          entities: [
            entity,
          ],
        ).then((value) {
          flag = value;
        });
        return flag;
      }
    );
    return flag;
  }

  @override
  Future<bool> downloadCsvLineChartAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  }) async {
    var usecase = ProcessElectrochemicalEntitiesUsecase(
      electrochemicalEntityRepository: electrochemicalEntityRepository,
    );
    final file = CsvLineChartElectrochemicalFile(folderPath: folderPath);
    if(!(await file.clear())) return false;
    final entities = <ElectrochemicalEntity>[];
    await usecase(
      processor: (entity) {
        if (entity == null) return true;
        entities.add(entity);
        return true;
      },
    );
    file.writeEntities(appLocalizations: appLocalizations, entities: entities);
    return true;
  }

  @override
  Future<bool> downloadCsvDpvLineChartAllElectrochemicalEntities({required AppLocalizations appLocalizations, required String folderPath}) async {
    var usecase = ProcessElectrochemicalEntitiesUsecase(
      electrochemicalEntityRepository: electrochemicalEntityRepository,
    );
    final file = CsvDpvLineChartElectrochemicalFile(folderPath: folderPath);
    if(!(await file.clear())) return false;
    final entities = <ElectrochemicalEntity>[];
    await usecase(
      processor: (entity) {
        if (entity == null) return true;
        entities.add(entity);
        return true;
      },
    );
    file.writeEntities(appLocalizations: appLocalizations, entities: entities);
    return true;
  }

  @override
  Future<bool> downloadJsonAllElectrochemicalEntities({
    required AppLocalizations appLocalizations,
    required String folderPath,
  }) async {
    var usecase = ProcessElectrochemicalEntitiesUsecase(
      electrochemicalEntityRepository: electrochemicalEntityRepository,
    );
    final file = JsonElectrochemicalFile(folderPath: folderPath);
    final entities = <ElectrochemicalEntity>[];
    await usecase(
      processor: (entity) {
        if (entity == null) return true;
        entities.add(entity);
        return true;
      },
    );
    file.writeEntities(entities: entities);
    return true;
  }
}
