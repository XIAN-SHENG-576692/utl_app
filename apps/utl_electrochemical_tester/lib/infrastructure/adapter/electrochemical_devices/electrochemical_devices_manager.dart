import 'dart:typed_data';

import 'package:bluetooth_utils/service/application/bluetooth_send_devices.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/bluetooth/bluetooth_sent_packet.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/bluetooth/electrochemical_bluetooth_buffer.dart';

import '../../../service/electrochemical/electrochemical_devices_manager.dart';
import '../../source/bluetooth/bluetooth_module.dart';

class ElectrochemicalDeviceImpl implements ElectrochemicalDevice {
  final BluetoothDevice device;
  final BluetoothSendDevices bluetoothSendDevices;
  ElectrochemicalDeviceImpl({
    required this.device,
    required this.bluetoothSendDevices,
  });
  static bool isConcreteElectrochemicalDevice(BluetoothDevice device) {
    return device.isConnected;
  }

  @override
  String get deviceId => device.remoteId.str;

  @override
  Future<bool> start({required String dataName, required Uint8List electrodes, required ElectrochemicalParameters parameters}) {
    ElectrochemicalBluetoothBuffer.setBuffer(
      dataName: dataName,
      deviceId: deviceId,
      parameters: parameters,
    );
    return bluetoothSendDevices.sendBytes(
      deviceFilter: isConcreteElectrochemicalDevice,
      bytes: StartElectrochemicalBluetoothSentPacket(
          parameters: parameters,
          electrodes: electrodes,
      ).data,
    ).then((value) => true);
  }

  @override
  Future<bool> stop() {
    return bluetoothSendDevices.sendBytes(
      deviceFilter: isConcreteElectrochemicalDevice,
      bytes: StopElectrochemicalBluetoothSentPacket().data,
    ).then((value) => true);
  }
}

class ElectrochemicalDevicesManagerImpl implements ElectrochemicalDevicesManager {
  final BluetoothModule bluetoothModule;
  ElectrochemicalDevicesManagerImpl({
    required this.bluetoothModule,
  });

  @override
  Iterable<ElectrochemicalDeviceImpl> get devices => bluetoothModule.devices
      .where(ElectrochemicalDeviceImpl.isConcreteElectrochemicalDevice)
      .map((device) => ElectrochemicalDeviceImpl(device: device, bluetoothSendDevices: bluetoothModule.bluetoothSendDevices));
}
