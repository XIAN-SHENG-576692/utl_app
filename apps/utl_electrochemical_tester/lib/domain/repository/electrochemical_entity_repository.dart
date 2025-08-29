import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';

abstract class ElectrochemicalEntityRepository {
  Stream<ElectrochemicalEntity?> fetchEntitiesByIds({
    required Iterable<int> entityIds,
  });

  Stream<ElectrochemicalEntity> fetchEntities();

  Stream<ElectrochemicalHeader?> fetchHeadersByIds({
    required Iterable<int> entityIds,
  });

  Stream<ElectrochemicalHeader> fetchHeaders();

  Future<int> countEntities();

  Stream<int> fetchIds();

  Stream<ElectrochemicalEntity> get entitySyncStream;

  Stream<int> get entityRemovedStream;

  Future<ElectrochemicalEntity> createEntityFromHeader({
    required ElectrochemicalHeader header,
    Iterable<ElectrochemicalData>? data,
  });

  Future<ElectrochemicalEntity?> upsertDataToEntity({
    required int entityId,
    required int index,
    required ElectrochemicalData data,
  });

  Future<bool> upsertEntity({
    required ElectrochemicalEntity entity,
  });

  Future<bool> clearRepository();
}
