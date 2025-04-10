import 'package:utl_electrochemical_tester/service/electrochemical/electrochemical_data_stream.dart';
import 'package:utl_electrochemical_tester/service/electrochemical/electrochemical_devices_manager.dart';
import 'package:utl_electrochemical_tester/service/file/file_handler.dart';
import 'package:utl_electrochemical_tester/service/local_storage/electrochemical_command_local_storage_handler.dart';

class ServiceResource {
  ServiceResource._();
  static late final ElectrochemicalDevicesManager electrochemicalDevicesManager;
  static late final ElectrochemicalDataStream electrochemicalDataStream;
  static late final FileHandler fileHandler;
  static late final ElectrochemicalCommandLocalStorageHandler electrochemicalCommandLocalStorageHandler;
}
