import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/bluetooth_services_tracker.dart';

/// Listens to incoming data from all tracked Bluetooth devices.
/// Registers notify/listen handlers on matching characteristics and descriptors.
class BluetoothReceiveAllDevices {
  final BluetoothServicesTracker bluetoothServicesTracker;
  final List<String> receivedUuid;
  final void Function(BluetoothCharacteristic characteristic, List<int> value) onReceiveCharacteristicValue;
  final void Function(BluetoothDescriptor descriptor, List<int> value) onReceiveDescriptorValueToPacket;

  BluetoothReceiveAllDevices({
    required this.bluetoothServicesTracker,
    required this.receivedUuid,
    required this.onReceiveCharacteristicValue,
    required this.onReceiveDescriptorValueToPacket,
  }) {
    // Setup initial listeners for existing buffers
    for (final buffer in bluetoothServicesTracker.buffers.toList(growable: false)) {
      _readPacket(buffer.device, buffer.services);
    }

    // Listen to updated services and bind listeners dynamically
    bluetoothServicesTracker.updatedServicesStream.listen((buffer) {
      _readPacket(buffer.device, buffer.services);
    });
  }

  /// Attach read/notify listeners to matching UUIDs on a given device's services
  Future<void> _readPacket(BluetoothDevice device, List<BluetoothService> services) async {
    if (!device.isConnected || services.isEmpty) return;

    for (final service in services) {
      for (final characteristic in service.characteristics.toList()) {
        if (receivedUuid.contains(characteristic.uuid.str)) {
          try {
            await characteristic.setNotifyValue(true);
            final sub = characteristic.onValueReceived.listen((value) {
              onReceiveCharacteristicValue(characteristic, value);
            });
            device.cancelWhenDisconnected(sub);
          } catch (e) {
            // Optionally log or handle error
          }
        }

        for (final descriptor in characteristic.descriptors.toList()) {
          if (receivedUuid.contains(descriptor.uuid.str)) {
            try {
              final sub = descriptor.onValueReceived.listen((value) {
                onReceiveDescriptorValueToPacket(descriptor, value);
              });
              device.cancelWhenDisconnected(sub);
            } catch (e) {
              // Optionally log or handle error
            }
          }
        }
      }
    }
  }
}
