import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:synchronized/synchronized.dart';

import '../domain/repository/seat_cushion_repository.dart';
import '../domain/usecase/seat_cushion_usecase.dart';
import '../infrastructure/source/csv_file/seat_cushion_csv_file.dart';

class FileHandler {
  final SeatCushionRepository seatCushionRepository;
  final String folder;
  FileHandler({
    required this.seatCushionRepository,
    required this.folder,
  });
  Future<bool> downloadSeatCushionCsvFile({
    required AppLocalizations appLocalizations,
  }) async {
    var file = SeatCushionCsvFile(
      folder: folder,
      appLocalizations: appLocalizations,
    );
    await file.clearThenGenerateHeader(appLocalizations: appLocalizations);
    bool flag = true;
    Lock lock = Lock();
    final handleSeatCushionEntitiesUseCase = HandleSeatCushionEntitiesUseCase(repository: seatCushionRepository);
    await handleSeatCushionEntitiesUseCase(
      start: 0,
      end: await seatCushionRepository.fetchEntitiesLength(),
      handler: (entity) async {
        lock.synchronized(() async {
          if(!flag) return;
          flag = await file.writeEntity(entity: entity);
        });
      },
    );
    return lock.synchronized(() => flag);
  }
}
