import 'package:hive_flutter/adapters.dart';
import 'package:synchronized/synchronized.dart';

import '../../../domain/entity/electrochemical_entity.dart';

class HiveSourceHandler {
  static const String _entityBoxName = "entityBox";
  static Future<HiveSourceHandler> init({
    required String hivePath,
  }) async {
    await Hive.initFlutter();

    Hive.init(hivePath);

    Hive.registerAdapter(ElectrochemicalDataAdapter());
    Hive.registerAdapter(ElectrochemicalEntityAdapter());
    Hive.registerAdapter(ElectrochemicalHeaderAdapter());
    Hive.registerAdapter(CaElectrochemicalParametersAdapter());
    Hive.registerAdapter(CvElectrochemicalParametersAdapter());
    Hive.registerAdapter(DpvElectrochemicalParametersAdapter());
    Hive.registerAdapter(DpvElectrochemicalParametersInversionOptionAdapter());

    var entityBox = await Hive.openLazyBox<ElectrochemicalEntity>(_entityBoxName);

    return HiveSourceHandler._(entityBox);
  }

  final LazyBox<ElectrochemicalEntity> _entityBox;

  final Lock _lock = Lock();
  HiveSourceHandler._(this._entityBox);

  int createNewId() {
    return _entityBox.length + 1;
  }

  Future<ElectrochemicalEntity?> fetchEntityById(int entityId) async {
    return _lock.synchronized(() async {
      var entity = await _entityBox.get(entityId);
      return entity;
    });
  }

  Future<ElectrochemicalHeader?> fetchHeadersByIds(int entityId) {
    return _lock.synchronized(() async {
      var entity = await _entityBox.get(entityId);
      return entity?.header;
    });
  }

  int countEntities() {
    return _entityBox.length;
  }

  Iterable<int> fetchEntityIds() {
    return _entityBox.keys.cast<int>();
  }

  Stream<ElectrochemicalEntity> get entitySyncStream {
    return _entityBox.watch()
      .where((event) => event.value is ElectrochemicalEntity)
      .asyncMap((event) async {
        return _lock.synchronized(() async {
          return (event.value as ElectrochemicalEntity);
        });
      });
  }

  Stream<int> get entityRemovedStream {
    return _entityBox.watch()
      .where((event) => event.value == null)
      .asyncMap((event) async {
        return _lock.synchronized(() async {
          return event.key;
        });
      });
  }

  Future<ElectrochemicalEntity> createEntityFromHeader({
    required ElectrochemicalHeader header,
    Iterable<ElectrochemicalData>? data,
  }) async {
    return _lock.synchronized(() async {
      final newEntity = ElectrochemicalEntity(
        id: createNewId(),
        header: header,
        data: data?.toList(growable: false) ?? List.empty(growable: false),
      );
      await _entityBox.put(newEntity.id, newEntity);
      return newEntity;
    });
  }

  Future<void> upsertEntity({
    required ElectrochemicalEntity entity,
  }) async {
    return _lock.synchronized(() {
      return _entityBox.put(entity.id, entity);
    });
  }

  Future<int> clearRepository() async {
    return _lock.synchronized(() {
      return _entityBox.clear();
    });
  }

  void dispose() {
    _entityBox.close();
  }
}
