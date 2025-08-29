import 'dart:typed_data';

import '../../../domain/model/entity/seat_cushion_entity.dart';
import '../../bluetooth/bluetooth_module.dart';

enum BluetoothPacketDtoForcesStage {
  first,
  second,
  third,
}

Map<BluetoothPacketDtoForcesStage, int> bluetoothPacketDtoForcesStageLengthMap = Map.fromIterable(
  BluetoothPacketDtoForcesStage.values,
  key: (stage) => stage,
  value: (stage) {
    switch(stage) {
      case BluetoothPacketDtoForcesStage.first:
        return 243;
      case BluetoothPacketDtoForcesStage.second:
        return 243;
      case BluetoothPacketDtoForcesStage.third:
        return 13;
    }
    throw Exception();
  },
);

class BluetoothPacketSeatCushionBuffer {
  final SeatCushionType seatCushionType;
  final String deviceId;
  final List<int> partForces;
  final BluetoothPacketDtoForcesStage forcesStage;
  static BluetoothPacketSeatCushionBuffer? create({
    required BluetoothPacket packet,
  }) {
    try{
      var packetLength = _extractPacketLength(bytes: packet.data);
      if(packetLength == null) return null;
      if(packetLength != packet.data.length) return null;
      var seatCushionType = _extractSeatCushionType(bytes: packet.data);
      if(seatCushionType == null) return null;
      var partForces = _extractPartForces(bytes: packet.data);
      if(partForces == null) return null;
      var forcesStage = _extractForcesStage(bytes: packet.data);
      if(forcesStage == null) return null;
      return BluetoothPacketSeatCushionBuffer._(
        seatCushionType: seatCushionType,
        deviceId: packet.deviceId,
        partForces: partForces,
        forcesStage: forcesStage,
      );
    } catch(e) {
      return null;
    }
  }
  BluetoothPacketSeatCushionBuffer._({
    required this.seatCushionType,
    required this.deviceId,
    required this.partForces,
    required this.forcesStage,
  });
  static int? _extractPacketLength({
    required Uint8List bytes,
  }) {
    var stage = _extractForcesStage(bytes: bytes);
    if(stage == null) return null;
    return bluetoothPacketDtoForcesStageLengthMap[stage];
  }
  static SeatCushionType? _extractSeatCushionType({
    required Uint8List bytes,
  }) {
    if(bytes.first & 0xF0 == 0x10) return SeatCushionType.right;
    if(bytes.first & 0xF0 == 0x20) return SeatCushionType.left;
    return null;
  }
  static BluetoothPacketDtoForcesStage? _extractForcesStage({
    required Uint8List bytes,
  }) {
    if(bytes.first & 0x0F == 0x01) return BluetoothPacketDtoForcesStage.first;
    if(bytes.first & 0x0F == 0x02) return BluetoothPacketDtoForcesStage.second;
    if(bytes.first & 0x0F == 0x03) return BluetoothPacketDtoForcesStage.third;
    return null;
  }
  static List<int>? _extractPartForces({
    required Uint8List bytes,
  }) {
    final int offset = 1;
    if(bytes.length <= offset) return null;
    if((bytes.length - 1) % 2 != 0) return null;
    final byteData = ByteData.sublistView(bytes);
    return [
      for (var i = offset; i < byteData.lengthInBytes; i += 2)
        byteData.getInt16(i, Endian.little)
    ];
  }
  @override
  String toString() {
    return "BluetoothPacketBuffer: "
        "\n\tseatCushionType: ${seatCushionType.name}"
        "\n\tdeviceId: $deviceId"
        "\n\tforcesStage: ${forcesStage.name}"
        "\n\tpartForces: $partForces"
    ;
  }
}
