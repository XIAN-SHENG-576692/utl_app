import 'dart:typed_data';

import 'package:common_utils/string.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/bluetooth_services_tracker.dart';

/// Sends data to all Bluetooth devices tracked by [BluetoothServicesTracker],
/// optionally filtered by device.
class BluetoothSendAllDevices {
  final BluetoothServicesTracker bluetoothServicesTracker;
  final List<String> sentUuid;
  final bool Function(BluetoothDevice device) deviceFilter;

  static bool _defaultDeviceFilter(BluetoothDevice device) => true;

  BluetoothSendAllDevices({
    required this.bluetoothServicesTracker,
    required this.sentUuid,
    this.deviceFilter = _defaultDeviceFilter,
  });

  /// Writes byte data to matching characteristics or descriptors
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

  /// Sends raw byte payload to all filtered devices
  Future<void> sendBytes(Uint8List bytes) async {
    for (var buffer in bluetoothServicesTracker.buffers) {
      if (deviceFilter(buffer.device)) {
        await _write(buffer.services, bytes);
      }
    }
  }

  /// Sends hex string (e.g. "A0B1C2") after converting to bytes
  Future<void> sendHexString(String hexString) async {
    late final Uint8List bytes;
    try {
      bytes = hexString.hexToUint8List();
    } catch (e) {
      // Invalid hex string format
      return;
    }

    for (var buffer in bluetoothServicesTracker.buffers) {
      if (deviceFilter(buffer.device)) {
        await _write(buffer.services, bytes);
      }
    }
  }
}
