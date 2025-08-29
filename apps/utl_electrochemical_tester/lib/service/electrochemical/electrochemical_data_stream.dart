import '../../domain/entity/electrochemical_entity.dart';

class ElectrochemicalDataStreamDto extends ElectrochemicalData {
  final int entityId;
  final String deviceId;
  final int index;
  const ElectrochemicalDataStreamDto({
    required this.entityId,
    required this.deviceId,
    required this.index,
    required super.data,
  });
}

abstract class ElectrochemicalStreamer {
  Stream<ElectrochemicalHeader> get headerStream;
  Stream<ElectrochemicalDataStreamDto> get dataStream;
}
