import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:utl_seat_cushion/domain/repository/seat_cushion_repository.dart';

import '../adaptor/seat_cushion.dart';
import '../service/data_stream/seat_cushion_sensor.dart';

class SeatCushionSensorDataHandler {
  @protected
  final SeatCushionSensorDataStream seatCushionSensorDataStream;
  @protected
  final SeatCushionRepository seatCushionRepository;
  late final StreamSubscription _streamSubscription;

  final StreamController<bool> _isSavingController = StreamController.broadcast();
  Stream<bool> get isSavingStream => _isSavingController.stream;
  bool _isSaving = false;
  bool get isSaving => _isSaving;
  set isSaving(bool isSaving) {
    if(_isSaving == isSaving) return;
    _isSaving = isSaving;
    _isSavingController.add(_isSaving);
  }

  SeatCushionSensorDataHandler({
    required this.seatCushionSensorDataStream,
    required this.seatCushionRepository,
  }) {
    final saveSeatCushionEntityBySensorDataUseCase = SaveSeatCushionEntityBySensorDataUseCase(
      seatCushionRepository: seatCushionRepository,
      idCreator: seatCushionRepository.generateEntityId,
    );
    _streamSubscription = seatCushionSensorDataStream.seatCushionSensorDataStream.listen((data) {
      if(!_isSaving) return;
      saveSeatCushionEntityBySensorDataUseCase(data: data);
    });
  }

  void dispose() {
    _streamSubscription.cancel();
  }
}
