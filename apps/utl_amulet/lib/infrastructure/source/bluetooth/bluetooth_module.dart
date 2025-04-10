import 'dart:async';

import 'package:bluetooth_utils/service/application/bluetooth_receive_all_devices.dart';
import 'package:bluetooth_utils/service/application/bluetooth_send_all_devices.dart';
import 'package:bluetooth_utils/service/devices/bluetooth_devices_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_auto_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_tracker.dart';
import 'package:common_utils/bytes.dart';
import 'package:flutter/material.dart';

import '../../../init/resource/infrastructure/bluetooth_resource.dart';
import 'bluetooth_received_packet.dart';

class BluetoothModule {
  final BluetoothDevicesTracker bluetoothDevicesTracker = BluetoothDevicesTracker();
  final BluetoothServicesTracker bluetoothServicesTracker = BluetoothServicesTracker();
  late final BluetoothServicesAutoTracker bluetoothServicesAutoTracker;
  late final BluetoothReceiveAllDevices bluetoothReceiveAllDevices;
  late final BluetoothSendAllDevices bluetoothSendAllDevices;
  final StreamController<BluetoothReceivedPacket> _controller = StreamController.broadcast();
  BluetoothModule() {
    bluetoothServicesAutoTracker = BluetoothServicesAutoTracker(
      bluetoothServicesTracker: bluetoothServicesTracker,
      bluetoothDevicesTracker: bluetoothDevicesTracker,
      shouldAutoDiscover: (_) => true,
    );
    bluetoothReceiveAllDevices = BluetoothReceiveAllDevices(
      bluetoothServicesTracker: bluetoothServicesTracker,
      receivedUuid: BluetoothResource.receivedUuids,
      onReceiveCharacteristicValue: (c, v) => _controller.add(BluetoothReceivedPacket(data: v.asUint8List(), deviceName: c.device.platformName, deviceId: c.device.remoteId.str)),
      onReceiveDescriptorValueToPacket: (d, v) => _controller.add(BluetoothReceivedPacket(data: v.asUint8List(), deviceName: d.device.platformName, deviceId: d.device.remoteId.str)),
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
  void mockPacket(BluetoothReceivedPacket packet) {
    _controller.add(packet);
  }
  Stream<BluetoothReceivedPacket> get onReceivePacket => _controller.stream;
  Future<bool> sendCommand({required String command}) async {
    await bluetoothSendAllDevices.sendHexString(command);
    return true;
  }
  void cancel() {
    _controller.close();
  }
}
