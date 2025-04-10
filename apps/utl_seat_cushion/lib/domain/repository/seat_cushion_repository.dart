import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';

/// Repository interface for managing seat cushion data
abstract class SeatCushionRepository {
  Future<bool> add({
    required SeatCushionEntity entity,
  });
  SeatCushionEntity? get lastEntity;
  Stream<SeatCushionEntity> get lastEntityStream;
  Stream<SeatCushionEntity> fetchEntities();
  Future<int> fetchEntitiesLength();
  Future<int> generateEntityId();
  Future<bool> clearAllEntities();
  bool get isClearingAllEntities;
  Stream<bool> get isClearingAllEntitiesStream;
  Future<bool> handleEntities({required int start, required int end, required void Function(SeatCushionEntity entity) handler});
}
