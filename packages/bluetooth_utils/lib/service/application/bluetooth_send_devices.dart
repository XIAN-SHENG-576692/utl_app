import 'dart:typed_data';

import 'package:common_utils/string.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/bluetooth_services_tracker.dart';

/// Responsible for writing data to Bluetooth devices' services/characteristics/descriptors
/// based on a UUID whitelist.
class BluetoothSendDevices {
  final BluetoothServicesTracker bluetoothServicesTracker;
  final List<String> sentUuid;

  BluetoothSendDevices({
    required this.bluetoothServicesTracker,
    required this.sentUuid,
  });

  /// Writes a byte payload to all matching characteristics and descriptors
  Future<void> _write(List<BluetoothService> services, Uint8List bytes) async {
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        await _writeToCharacteristic(characteristic, bytes);
        await _writeToDescriptors(characteristic.descriptors, bytes);
      }
    }
  }

  Future<void> _writeToCharacteristic(BluetoothCharacteristic c, Uint8List bytes) async {
    if (sentUuid.contains(c.uuid.str)) {
      try {
        await c.write(bytes);
      } catch (e) {
        // Optionally log or handle error
      }
    }
  }

  Future<void> _writeToDescriptors(List<BluetoothDescriptor> descriptors, Uint8List bytes) async {
    for (var d in descriptors) {
      if (sentUuid.contains(d.uuid.str)) {
        try {
          await d.write(bytes);
        } catch (e) {
          // Optionally log or handle error
        }
      }
    }
  }

  /// Sends raw bytes to all connected services that match filtered devices
  Future<void> sendBytes({
    required bool Function(BluetoothDevice device) deviceFilter,
    required Uint8List bytes,
  }) async {
    for (var buffer in bluetoothServicesTracker.buffers) {
      if (deviceFilter(buffer.device)) {
        await _write(buffer.services, bytes);
      }
    }
  }

  /// Sends a hex string payload (e.g. "A0B1C2") after converting to bytes
  Future<void> sendHexString({
    required bool Function(BluetoothDevice device) deviceFilter,
    required String hexString,
  }) async {
    late final Uint8List bytes;
    try {
      bytes = hexString.hexToUint8List();
    } catch (e) {
      // Invalid hex string, silently return
      return;
    }

    for (var buffer in bluetoothServicesTracker.buffers) {
      if (deviceFilter(buffer.device)) {
        await _write(buffer.services, bytes);
      }
    }
  }
}
