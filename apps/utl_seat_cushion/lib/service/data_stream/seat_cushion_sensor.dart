import 'package:flutter/material.dart';

import '../../domain/model/entity/seat_cushion_entity.dart';

class SeatCushionSensorData extends SeatCushionEntity {
  @protected
  @override
  int get id => 0;
  const SeatCushionSensorData({
    required super.deviceId,
    required super.forces,
    required super.type,
  }) : super(
    id: 0,
  );
  @override
  List<Object?> get props => [
    deviceId,
    forces,
    type,
  ];
}

abstract class SeatCushionSensorDataStream {
  Stream<SeatCushionSensorData> get seatCushionSensorDataStream;
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  void mockData({
    required SeatCushionSensorData data,
  });
}
