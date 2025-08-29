import 'dart:typed_data';

import '../../domain/entity/electrochemical_entity.dart';

abstract class ElectrochemicalDevice {
  String get deviceId;
  Future<bool> start({
    required String dataName,
    required Uint8List electrodes,
    required ElectrochemicalParameters parameters,
  });
  Future<bool> stop();
}

abstract class ElectrochemicalDevicesManager {
  Iterable<ElectrochemicalDevice> get devices;
}
