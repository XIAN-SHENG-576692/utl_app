import 'package:flutter/widgets.dart';
import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';
import 'package:utl_seat_cushion/service/data_stream/seat_cushion_sensor.dart';

import '../domain/repository/seat_cushion_repository.dart';

/// Save seat cushion use case
class SaveSeatCushionEntityBySensorDataUseCase {
  @protected
  final SeatCushionRepository seatCushionRepository;
  @protected
  final Future<int> Function() idCreator;

  SaveSeatCushionEntityBySensorDataUseCase({
    required this.seatCushionRepository,
    required this.idCreator,
  });

  Future<void> call({
    required SeatCushionSensorData data,
  }) async {
    seatCushionRepository.add(entity: SeatCushionEntity(
      id: await idCreator(),
      deviceId: data.deviceId,
      forces: data.forces,
      type: data.type,
    ));
  }
}
