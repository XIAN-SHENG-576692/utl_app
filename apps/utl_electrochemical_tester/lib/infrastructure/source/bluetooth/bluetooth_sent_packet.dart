import 'dart:typed_data';

import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/bluetooth/bytes_mapper.dart';

abstract class BluetoothSentPacket {
  Uint8List get data;
}

class StartElectrochemicalBluetoothSentPacket {
  ElectrochemicalParameters parameters;
  Uint8List electrodes;
  StartElectrochemicalBluetoothSentPacket({
    required this.parameters,
    required this.electrodes,
  });
  Uint8List get data {
    final bytes = BytesMapper.mapElectrochemicalParametersToByteData(
      parameters: parameters,
      align: true,
    ).buffer.asUint8List();
    return Uint8List.fromList([
      0x01,
      parameters.type.index + 1,
      ...bytes,
      ...electrodes,
    ]);
  }
  @override
  String toString() {
    return "StartElectrochemicalBluetoothSentPacket: "
        "\n\tdata: $data"
    ;
  }
}

class StopElectrochemicalBluetoothSentPacket {
  StopElectrochemicalBluetoothSentPacket();
  Uint8List get data {
    return Uint8List.fromList([
      0x01,
      0x00,
    ]);
  }
}
