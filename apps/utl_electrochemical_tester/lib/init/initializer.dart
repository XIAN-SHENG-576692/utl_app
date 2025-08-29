import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_utils/path_provider_utils.dart';
import 'package:utl_electrochemical_tester/infrastructure/adapter/electrochemical_devices/electrochemical_data_stream.dart';
import 'package:utl_electrochemical_tester/infrastructure/adapter/electrochemical_devices/electrochemical_devices_manager.dart';
import 'package:utl_electrochemical_tester/infrastructure/adapter/local_storage/electrochemical_command_local_storage_handler.dart';
import 'package:utl_electrochemical_tester/infrastructure/repository/electrochemical_entity_repository.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/bluetooth/bluetooth_module.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/bluetooth/electrochemical_bluetooth_buffer.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/hive/hive_source_handler.dart';
import 'package:utl_electrochemical_tester/infrastructure/source/shared_preferences/shared_preferences_handler.dart';
import 'package:utl_electrochemical_tester/init/application_persist.dart';
import 'package:utl_electrochemical_tester/init/resource/service/service_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/infrastructure/bluetooth_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/infrastructure/hive_source.dart';
import 'package:utl_electrochemical_tester/init/resource/infrastructure/path_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/infrastructure/shared_preferences_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/data/repository_resource.dart';
import 'package:utl_electrochemical_tester/infrastructure/adapter/file/file_handler.dart';

class Initializer {
  Future<void> call() async {
    FlutterBluePlus.setLogLevel(LogLevel.none);
    BluetoothResource.bluetoothModule = BluetoothModule();

    PathResource.downloadPath = ((await getSystemDownloadDirectory()) ?? (await getApplicationDocumentsDirectory())).absolute.path;
    PathResource.hivePath = (await getApplicationDocumentsDirectory()).absolute.path;

    HiveSource.hiveSourceHandler = await HiveSourceHandler.init(
      hivePath: PathResource.hivePath,
    );

    SharedPreferencesResource.sharedPreferencesHandler = await SharedPreferencesHandler.init();

    RepositoryResource.electrochemicalEntityRepository = ElectrochemicalEntityRepositoryImpl(
      hiveSourceHandler: HiveSource.hiveSourceHandler,
    );

    ServiceResource.electrochemicalDevicesManager = ElectrochemicalDevicesManagerImpl(bluetoothModule: BluetoothResource.bluetoothModule);
    ServiceResource.electrochemicalDataStream = ElectrochemicalDataStreamImpl(bluetoothModule: BluetoothResource.bluetoothModule);
    ServiceResource.fileHandler = FileHandlerImpl(
      electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
    );
    ServiceResource.electrochemicalCommandLocalStorageHandler = ElectrochemicalCommandLocalStorageHandlerImpl(
      sharedPreferencesHandler: SharedPreferencesResource.sharedPreferencesHandler,
    );

    ElectrochemicalBluetoothBuffer.init(
      electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
    );
    ApplicationPersist.init();
    ApplicationPersist.electrochemicalEntityCreator.start();
    ApplicationPersist.electrochemicalRinging.start();
  }
}
