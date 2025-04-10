import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:utl_amulet/service/file/file_handler.dart';
import 'package:utl_amulet/domain/entity/amulet_entity.dart';
import 'package:utl_amulet/infrastructure/source/csv_file/amulet_csv_file.dart';

class FileHandlerImpl implements FileHandler {

  String amuletFileDownloadFolder;

  FileHandlerImpl({
    required this.amuletFileDownloadFolder,
  });

  @override
  Future<bool> downloadAmuletEntitiesFile({
    required AppLocalizations appLocalizations,
    required Stream<AmuletEntity> fetchEntitiesStream,
  }) async {
    final file = AmuletCsvFile(
      folderPath: amuletFileDownloadFolder,
    );
    await file.clearThenGenerateHeader(appLocalizations: appLocalizations);
    await for(var entity in fetchEntitiesStream) {
      if(!(await file.writeEntities(entities: [entity]))) return false;
    }
    return true;
  }

}
