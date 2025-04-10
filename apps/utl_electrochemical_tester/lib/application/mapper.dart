part of 'electrochemical_entity_creator.dart';

class _Mapper {
  _Mapper._();
  static ElectrochemicalHeader mapDtoToHeader({
    required ElectrochemicalDeviceReceivedHeaderDto dto,
  }) {
    return ElectrochemicalHeader(
      dataName: dto.dataName,
      deviceId: dto.deviceId,
      createdTime: dto.createdTime,
      temperature: dto.temperature,
      parameters: dto.parameters,
    );
  }
  static ElectrochemicalData mapDtoToData({
    required ElectrochemicalDeviceReceivedDataDto dto,
  }) {
    return ElectrochemicalData(
      index: dto.index,
      time: dto.time,
      voltage: dto.voltage,
      current: dto.current,
    );
  }
}
