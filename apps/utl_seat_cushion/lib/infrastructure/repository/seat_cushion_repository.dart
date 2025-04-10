import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';
import 'package:utl_seat_cushion/domain/repository/seat_cushion_repository.dart';
import 'package:utl_seat_cushion/infrastructure/source/in_memoty/in_memory.dart';

class SeatCushionRepositoryImpl implements SeatCushionRepository {
  final InMemoryRepository inMemoryRepository;

  SeatCushionRepositoryImpl({
    required this.inMemoryRepository,
  });

  @override
  Future<bool> add({required SeatCushionEntity entity}) async {
    return inMemoryRepository.add(entity: entity);
  }

  @override
  Future<bool> clearAllEntities() {
    return inMemoryRepository.clearAllEntities();
  }

  @override
  bool get isClearingAllEntities => inMemoryRepository.isClearing;

  @override
  Stream<bool> get isClearingAllEntitiesStream => inMemoryRepository.isClearingStream;

  @override
  Stream<SeatCushionEntity> fetchEntities() {
    return inMemoryRepository.fetchEntities();
  }

  @override
  Future<int> fetchEntitiesLength() {
    return inMemoryRepository.fetchEntitiesLength();
  }

  @override
  Future<int> generateEntityId() {
    return inMemoryRepository.generateEntityId();
  }

  @override
  Future<bool> handleEntities({required int start, required int end, required void Function(SeatCushionEntity entity) handler}) {
    return inMemoryRepository.handleEntities(start: start, end: end, handler: handler);
  }

  @override
  SeatCushionEntity? get lastEntity => inMemoryRepository.lastEntity;

  @override
  Stream<SeatCushionEntity> get lastEntityStream => inMemoryRepository.lastEntityStream;
  
}