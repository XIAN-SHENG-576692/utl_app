import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';
import 'package:utl_seat_cushion/infrastructure/bluetooth/bluetooth_module.dart';
import 'package:utl_seat_cushion/init/resource/data_resource.dart';
import 'package:utl_seat_cushion/service/data_stream/seat_cushion_sensor.dart';

class FakeDataGenerator {
  var headers = [
    0x11,
    0x12,
    0x13,
    0x21,
    0x22,
    0x23,
  ];
  var forcesLengths = [
    242,
    242,
    12,
    242,
    242,
    12,
  ];
  int generateRandomForceInt() {
    return Random.secure().nextInt((SeatCushionParameters.forceMax - SeatCushionParameters.forceMin) + SeatCushionParameters.forceMin);
  }
  ByteData generateRandomForceByteData() {
    return ByteData(2)..setInt16(0, generateRandomForceInt(), Endian.little);
  }
  Future<SeatCushionEntity> createFakeSeatCushionEntity() async {
    return SeatCushionEntity(
      id: await DataResource.seatCushionRepository.generateEntityId(),
      deviceId: "",
      forces: List.generate(
        SeatCushionParameters.unitsMaxRow * SeatCushionParameters.unitsMaxColumn,
            (index) {
          return generateRandomForceInt();
        },
      ),
      type: SeatCushionType.values[Random.secure().nextInt(SeatCushionType.values.length)],
    );
  }
  SeatCushionSensorData createFakeSeatCushionSensorData() {
    return SeatCushionSensorData(
      deviceId: "",
      forces: List.generate(
        SeatCushionParameters.unitsMaxRow * SeatCushionParameters.unitsMaxColumn,
        (index) {
          return generateRandomForceInt();
        },
      ),
      type: SeatCushionType.values[Random.secure().nextInt(SeatCushionType.values.length)],
    );
  }
  BluetoothPacket createFakeBluetoothPacket() {
    int index = Random.secure().nextInt(headers.length);
    return BluetoothPacket(
      data: Uint8List.fromList([
        headers[index],
        ...Iterable.generate(
          (forcesLengths[index] / 2).toInt(),
          (_) => generateRandomForceByteData().buffer.asUint8List(),
        ).expand((byteData) => byteData),
      ]),
      deviceId: "123",
    );
  }
}