import 'package:utl_electrochemical_tester/service/electrochemical/dto/electrochemical_device_sent_dto.dart';

abstract class ElectrochemicalDevice {
  String get deviceId;
  Future<bool> startCa({
    required CaElectrochemicalDeviceSentDto dto,
  });
  Future<bool> startCv({
    required CvElectrochemicalDeviceSentDto dto,
  });
  Future<bool> startDpv({
    required DpvElectrochemicalDeviceSentDto dto,
  });
}

abstract class ElectrochemicalDevicesManager {
  Iterable<ElectrochemicalDevice> get devices;
}
