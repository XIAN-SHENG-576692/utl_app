import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:utl_ad5940_quick_tester/domain/value/electrochemical_parameters.dart';
import 'package:utl_ad5940_quick_tester/infrastructure/bluetooth/bluetooth_module.dart';
import 'package:utl_ad5940_quick_tester/infrastructure/service/data_stream/electrochemical_data_stream.dart';
import 'package:utl_ad5940_quick_tester/init/resource/service_resource.dart';

import 'independent_bluetooth_module.dart';

void main() {
  test('Electrochemical header parse test', () async {
    final bluetoothModule = IndependentPlatformBluetoothModule();
    ServiceResource.electrochemicalDataStream = ElectrochemicalDataStreamImpl(bluetoothModule: bluetoothModule);
    expectLater(
      ServiceResource.electrochemicalDataStream.headerStream.map((header) => [
        header.id,
        header.header.type,
        header.header.cvParameters,
        header.header.temperature,
        header.header.electrodeRouting,
        header.header.hsRTia.magnitude,
        header.header.hsRTia.phase,
        header.header.adcPga,
        header.header.vRef1p82,
      ]),
      emitsInOrder([
        [
          0,
          ElectrochemicalType.cv,
          CvElectrochemicalParameters(eBegin: -0.6, eVertex1: -0.6, eVertex2: 0.6, eStep: 0.01, scanRate: 0.01, numberOfScans: 1),
          28.613038,
          [16, 0, 0, 0, 16, 0, 0, 0, 4, 0, 0, 0, 4, 1, 0, 0],
          10000.0,
          0.0,
          1.0,
          1.82
        ],
      ]),
    );
    bluetoothModule.mockPacket(
      BluetoothPacket(
        data: Uint8List.fromList([0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x9A, 0x99, 0x19, 0xBF, 0x9A, 0x99, 0x19, 0xBF, 0x9A, 0x99, 0x19, 0x3F, 0x0A, 0xD7, 0x23, 0x3C, 0x0A, 0xD7, 0x23, 0x3C, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAE, 0x99, 0xB4, 0x01, 0x10, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x01, 0x00, 0x00, 0x00, 0x40, 0x1C, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x3F, 0xC3, 0xF5, 0xE8, 0x3F]),
        deviceName: "deviceName",
        deviceId: "deviceId",
      ),
    );
  });
}
