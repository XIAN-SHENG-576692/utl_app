import 'dart:async';
import 'dart:typed_data';

import 'package:bluetooth_utils/service/application/bluetooth_receive_all_devices.dart';
import 'package:bluetooth_utils/service/application/bluetooth_send_all_devices.dart';
import 'package:bluetooth_utils/service/devices/bluetooth_devices_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_auto_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_tracker.dart';
import 'package:utl_ad5940_quick_tester/infrastructure/bluetooth/bluetooth_module.dart';

class IndependentPlatformBluetoothModule implements BluetoothModule {
  final StreamController<BluetoothPacket> _controller = StreamController.broadcast();

  @override
  late BluetoothReceiveAllDevices bluetoothReceiveAllDevices;

  @override
  late BluetoothSendAllDevices bluetoothSendAllDevices;

  @override
  late BluetoothServicesAutoTracker bluetoothServicesAutoTracker;

  @override
  // TODO: implement bluetoothDevicesTracker
  BluetoothDevicesTracker get bluetoothDevicesTracker => throw UnimplementedError();

  @override
  // TODO: implement bluetoothServicesTracker
  BluetoothServicesTracker get bluetoothServicesTracker => throw UnimplementedError();

  @override
  void cancel() {
    // TODO: implement cancel
  }

  @override
  Uint8List generateElectrochemicalCommand({required Uint8List bytes}) {
    // TODO: implement generateElectrochemicalCommand
    throw UnimplementedError();
  }

  @override
  void mockPacket(BluetoothPacket packet) {
    _controller.add(packet);
  }

  @override
  Stream<BluetoothPacket> get onReceive => _controller.stream;

  @override
  Future<bool> sendBytesToAllDevices({required Uint8List bytes}) {
    // TODO: implement sendBytesToAllDevices
    throw UnimplementedError();
  }

  @override
  Future<bool> sendHexStringToAllDevices({required String hexString}) {
    // TODO: implement sendHexStringToAllDevices
    throw UnimplementedError();
  }
}
