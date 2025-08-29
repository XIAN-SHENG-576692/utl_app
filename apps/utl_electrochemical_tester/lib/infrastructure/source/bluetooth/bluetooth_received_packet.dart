import 'dart:typed_data';

import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/bluetooth/electrochemical_bluetooth_buffer.dart';

import '../../../service/electrochemical/electrochemical_data_stream.dart';

class BluetoothReceivedPacket {
  const BluetoothReceivedPacket({
    required this.deviceId,
    required this.deviceName,
    required this.bytes,
  });
  final String deviceId;
  final String deviceName;
  final Uint8List bytes;
  @override
  String toString() {
    return "BluetoothReceivedPacket: "
        "\n\tdeviceId: $deviceId"
        "\n\tdeviceName: $deviceName"
        "\n\tdata: $bytes"
    ;
  }
  ElectrochemicalHeader? mapToHeader() {
    var dataName = ElectrochemicalBluetoothBuffer.getDataName(deviceId: deviceId);
    if(dataName == null) return null;
    var parameters = ElectrochemicalBluetoothBuffer.getParameters(deviceId: deviceId);
    if(parameters == null) return null;
    if(bytes.length != 8) return null;
    if(bytes[0] != 0x02) return null;
    if(bytes[1] != 0x00) return null;
    ByteData byteData = ByteData.sublistView(bytes);
    double temperature = byteData.getFloat32(4, Endian.little);
    return ElectrochemicalHeader.createWithoutError(
      dataName: dataName,
      deviceId: deviceId,
      deviceName: deviceName,
      createdTime: DateTime.now(),
      parameters: parameters,
      temperature: temperature,
    );
  }
  ElectrochemicalDataStreamDto? mapToData() {
    var entityId = ElectrochemicalBluetoothBuffer.getEntityId(deviceId: deviceId);
    if(entityId == null) return null;
    if(bytes.length != 8) return null;
    if(bytes[0] != 0x02) return null;
    if(bytes[1] != 0x01) return null;
    ByteData byteData = ByteData.sublistView(bytes);
    int index = byteData.getInt16(2, Endian.little);
    double data = byteData.getFloat32(4, Endian.little);
    return ElectrochemicalDataStreamDto(
      entityId: entityId,
      deviceId: deviceId,
      index: index,
      data: data,
    );
  }
}
