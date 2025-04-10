import 'package:utl_electrochemical_tester/service/electrochemical/dto/electrochemical_device_received_dto.dart';

abstract class ElectrochemicalDataStream {
  Stream<ElectrochemicalDeviceReceivedHeaderDto> get headerStream;
  Stream<ElectrochemicalDeviceReceivedDataDto> get dataStream;
}
