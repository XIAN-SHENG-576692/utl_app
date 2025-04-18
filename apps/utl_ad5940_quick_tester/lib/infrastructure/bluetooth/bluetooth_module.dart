import 'dart:async';
import 'dart:typed_data';

import 'package:bluetooth_utils/service/application/bluetooth_receive_all_devices.dart';
import 'package:bluetooth_utils/service/application/bluetooth_send_all_devices.dart';
import 'package:bluetooth_utils/service/devices/bluetooth_devices_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_auto_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_tracker.dart';
import 'package:common_utils/bytes.dart';
import 'package:flutter/material.dart';

import '../../init/resource/bluetooth_resource.dart';

class BluetoothPacket {
  final Uint8List data;
  final String deviceName;
  final String deviceId;
  BluetoothPacket({
    required this.data,
    required this.deviceName,
    required this.deviceId,
  });
}

class BluetoothModule {
  final BluetoothDevicesTracker bluetoothDevicesTracker = BluetoothDevicesTracker();
  final BluetoothServicesTracker bluetoothServicesTracker = BluetoothServicesTracker();
  late final BluetoothServicesAutoTracker bluetoothServicesAutoTracker;
  late final BluetoothReceiveAllDevices bluetoothReceiveAllDevices;
  late final BluetoothSendAllDevices bluetoothSendAllDevices;
  final StreamController<BluetoothPacket> _controller = StreamController.broadcast();
  BluetoothModule() {
    bluetoothServicesAutoTracker = BluetoothServicesAutoTracker(
      bluetoothServicesTracker: bluetoothServicesTracker,
      bluetoothDevicesTracker: bluetoothDevicesTracker,
      shouldAutoDiscover: (_) => true,
    );
    bluetoothReceiveAllDevices = BluetoothReceiveAllDevices(
      bluetoothServicesTracker: bluetoothServicesTracker,
      receivedUuid: BluetoothResource.receivedUuids,
      onReceiveCharacteristicValue: (c, v) => _controller.add(BluetoothPacket(data: v.asUint8List(), deviceName: c.device.platformName, deviceId: c.device.remoteId.str)),
      onReceiveDescriptorValueToPacket: (d, v) => _controller.add(BluetoothPacket(data: v.asUint8List(), deviceName: d.device.platformName, deviceId: d.device.remoteId.str)),
    );
    bluetoothSendAllDevices = BluetoothSendAllDevices(
      bluetoothServicesTracker: bluetoothServicesTracker,
      sentUuid: BluetoothResource.sentUuids,
    );
    bluetoothDevicesTracker.startTracking(
      getSystemDevices: true,
    );
  }
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  void mockPacket(BluetoothPacket packet) {
    _controller.add(packet);
  }
  Stream<BluetoothPacket> get onReceive => _controller.stream;
  Future<bool> sendHexStringToAllDevices({required String hexString}) async {
    await bluetoothSendAllDevices.sendHexString(hexString);
    return true;
  }
  Future<bool> sendBytesToAllDevices({required Uint8List bytes}) async {
    await bluetoothSendAllDevices.sendBytes(bytes);
    return true;
  }
  int _counter = 0;
  Uint8List generateElectrochemicalCommand({required Uint8List bytes}) {
    final byteData = ByteData(4);
    byteData.setUint32(0, _counter, Endian.big);
    _counter++;
    return Uint8List.fromList([
      0x01,
      ...byteData.buffer.asUint8List(),
      ...bytes,
    ]);
  }
  void cancel() {
    _controller.close();
  }
}
