import 'dart:async';

import 'package:synchronized/synchronized.dart';
import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';

class InMemoryRepository {

  final StreamController<SeatCushionEntity> _lastEntityController = StreamController.broadcast();
  Stream<SeatCushionEntity> get lastEntityStream => _lastEntityController.stream;
  SeatCushionEntity? _lastEntity;
  SeatCushionEntity? get lastEntity => _lastEntity;
  set lastEntity(SeatCushionEntity? entity) {
    if(entity == null || _lastEntity == entity) return;
    _lastEntity = entity;
    _lastEntityController.add(entity);
  }

  final StreamController<bool> _isClearingController = StreamController.broadcast();
  Stream<bool> get isClearingStream => _isClearingController.stream;
  bool _isClearing = false;
  bool get isClearing => _isClearing;
  set isClearing(bool isClearing) {
    if(_isClearing == isClearing) return;
    _isClearing = isClearing;
    _isClearingController.add(isClearing);
  }

  final List<SeatCushionEntity> entities = [];
  final Lock _entityLock = Lock();
  Future<bool> add({
    required SeatCushionEntity entity,
  }) {
    return _entityLock.synchronized(() {
      entities.add(entity);
      lastEntity = entity;
      return true;
    });
  }
  Stream<SeatCushionEntity> fetchEntities() async* {
    for(var entity in entities.toList()) {
      yield entity;
    }
  }
  Future<bool> handleEntities({
    required int start,
    required int end,
    required void Function(SeatCushionEntity entity) handler,
  }) async {
    return _entityLock.synchronized(() {
      for(var entity in entities.skip(start).take(end)) {
        handler(entity);
      }
      return true;
    });
  }
  Future<int> fetchEntitiesLength() {
    return _entityLock.synchronized(() {
      return entities.length;
    });
  }
  Future<int> generateEntityId() {
    return fetchEntitiesLength();
  }
  Future<bool> clearAllEntities() {
    return _entityLock.synchronized(() {
      isClearing = true;
      entities.clear();
      isClearing = false;
      return true;
    });
  }
  void dispose() {
    _lastEntityController.close();
  }
}
