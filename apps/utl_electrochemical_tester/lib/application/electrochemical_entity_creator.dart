import 'dart:async';

import 'package:utl_electrochemical_tester/domain/repository/electrochemical_entity_repository.dart';
import 'package:utl_electrochemical_tester/service/electrochemical/electrochemical_data_stream.dart';

import '../domain/value/electrochemical_data.dart';
import '../domain/value/electrochemical_header.dart';
import '../service/electrochemical/dto/electrochemical_device_received_dto.dart';

part 'mapper.dart';

class ElectrochemicalEntityCreator {
  late final StreamSubscription<ElectrochemicalDeviceReceivedHeaderDto> headerStream;
  late final StreamSubscription<ElectrochemicalDeviceReceivedDataDto> dataStream;
  final ElectrochemicalEntityRepository electrochemicalEntityRepository;
  bool _isStarting = false;
  ElectrochemicalEntityCreator({
    required this.electrochemicalEntityRepository,
    required ElectrochemicalDataStream electrochemicalDataStream,
  }) {
    headerStream = electrochemicalDataStream.headerStream.listen((dto) {
      if(!_isStarting) return;
      electrochemicalEntityRepository.createEntityFromHeader(
        header: _Mapper.mapDtoToHeader(dto: dto),
      );
    });
    dataStream = electrochemicalDataStream.dataStream.listen((dto) {
      if(!_isStarting) return;
      electrochemicalEntityRepository.appendDataToEntity(
        entityId: dto.entityId,
        data: [_Mapper.mapDtoToData(dto: dto)],
      );
    });
  }
  void start() {
    _isStarting = true;
  }
  void stop() {
    _isStarting = false;
  }
  void dispose() {
    headerStream.cancel();
    dataStream.cancel();
  }
}
