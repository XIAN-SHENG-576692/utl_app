import 'dart:async';
import 'dart:typed_data';

import 'package:bluetooth_utils/service/application/bluetooth_receive_all_devices.dart';
import 'package:bluetooth_utils/service/application/bluetooth_send_all_devices.dart';
import 'package:bluetooth_utils/service/application/bluetooth_send_devices.dart';
import 'package:bluetooth_utils/service/devices/bluetooth_devices_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_auto_tracker.dart';
import 'package:bluetooth_utils/service/services/bluetooth_services_tracker.dart';
import 'package:common_utils/bytes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/bluetooth/bluetooth_received_packet.dart';

import '../../../domain/entity/electrochemical_entity.dart';
import '../../../init/resource/infrastructure/bluetooth_resource.dart';
import '../../../service/electrochemical/electrochemical_data_stream.dart';
import 'bluetooth_packet_handler.dart';
import 'bluetooth_sent_packet.dart';

class BluetoothPacket {
  final Uint8List data;
  final String deviceId;
  BluetoothPacket({
    required this.data,
    required this.deviceId,
  });
}

class BluetoothModule {
  final BluetoothDevicesTracker bluetoothDevicesTracker = BluetoothDevicesTracker();
  final BluetoothServicesTracker bluetoothServicesTracker = BluetoothServicesTracker();
  late final BluetoothServicesAutoTracker bluetoothServicesAutoTracker;
  late final BluetoothReceiveAllDevices bluetoothReceiveAllDevices;
  late final BluetoothSendAllDevices bluetoothSendAllDevices;
  late final BluetoothSendDevices bluetoothSendDevices;
  final BluetoothPacketHandler bluetoothPacketHandler = BluetoothPacketHandlerImpl();
  BluetoothModule() {
    bluetoothServicesAutoTracker = BluetoothServicesAutoTracker(
      bluetoothServicesTracker: bluetoothServicesTracker,
      bluetoothDevicesTracker: bluetoothDevicesTracker,
      shouldAutoDiscover: (_) => true,
    );
    bluetoothReceiveAllDevices = BluetoothReceiveAllDevices(
      bluetoothServicesTracker: bluetoothServicesTracker,
      receivedUuid: BluetoothResource.receivedUuids,
      onReceiveCharacteristicValue: (c, v) => bluetoothPacketHandler.handleReceivedPacket(
        packet: BluetoothReceivedPacket(
          deviceId: c.remoteId.str,
          deviceName: c.device.platformName,
          bytes: v.asUint8List(),
        ),
      ),
      onReceiveDescriptorValueToPacket: (d, v) => bluetoothPacketHandler.handleReceivedPacket(
        packet: BluetoothReceivedPacket(
          deviceId: d.remoteId.str,
          deviceName: d.device.platformName,
          bytes: v.asUint8List(),
        ),
      ),
    );
    bluetoothSendAllDevices = BluetoothSendAllDevices(
      bluetoothServicesTracker: bluetoothServicesTracker,
      sentUuid: BluetoothResource.sentUuids,
    );
    bluetoothSendDevices = BluetoothSendDevices(
      bluetoothServicesTracker: bluetoothServicesTracker,
      sentUuid: BluetoothResource.sentUuids,
    );
    bluetoothDevicesTracker.startTracking(
      getSystemDevices: true,
    );
  }
  Iterable<BluetoothDevice> get devices => bluetoothDevicesTracker.devices;
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  void mockPacket(BluetoothReceivedPacket packet) {
    bluetoothPacketHandler.handleReceivedPacket(
      packet: packet,
    );
  }
  Stream<ElectrochemicalDataStreamDto> get electrochemicalDataStream => bluetoothPacketHandler.electrochemicalDataStream;
  Stream<ElectrochemicalHeader> get electrochemicalHeaderStream => bluetoothPacketHandler.electrochemicalHeaderStream;
  Future<bool> sendPacket({required BluetoothSentPacket packet}) async {
    await bluetoothSendAllDevices.sendBytes(packet.data);
    return true;
  }
}
