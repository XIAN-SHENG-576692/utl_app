import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_utils/path_provider_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utl_seat_cushion/infrastructure/bluetooth/bluetooth_module.dart';
import 'package:utl_seat_cushion/infrastructure/repository/seat_cushion_repository.dart';
import 'package:utl_seat_cushion/infrastructure/service/data_stream/seat_cushion_sensor.dart';
import 'package:utl_seat_cushion/infrastructure/source/in_memoty/in_memory.dart';
import 'package:utl_seat_cushion/init/application_persist.dart';
import 'package:utl_seat_cushion/init/resource/bluetooth_resource.dart';
import 'package:utl_seat_cushion/init/resource/data_resource.dart';
import 'package:utl_seat_cushion/init/resource/path_resource.dart';
import 'package:utl_seat_cushion/init/resource/service_resource.dart';
import 'package:utl_seat_cushion/service/file_handler.dart';

class Initializer {
  Future call() async {
    PathResource.downloadPath = ((await getSystemDownloadDirectory()) ?? (await getApplicationDocumentsDirectory())).absolute.path;

    DataResource.sharedPreferences = await SharedPreferences.getInstance();
    DataResource.seatCushionRepository = SeatCushionRepositoryImpl(
      inMemoryRepository: InMemoryRepository(),
    );

    // await HiveDatabaseRepository.init();
    // databaseRepository = HiveDatabaseRepository();

    // inMemoryRepository = ConcreteInMemoryRepository(
    //   maxLength: 100,
    // );
    // electrochemicalDataService = ConcreteElectrochemicalDataService(
    //   databaseRepository: databaseRepository,
    //   inMemoryRepository: inMemoryRepository,
    // )..loadToMemory();

    FlutterBluePlus.setLogLevel(LogLevel.none);
    BluetoothResource.bluetoothModule = BluetoothModule();

    ServiceResource.fileHandler = FileHandler(
      seatCushionRepository: DataResource.seatCushionRepository,
      folder: PathResource.downloadPath,
    );
    ServiceResource.seatCushionSensorDataStream = SeatCushionSensorDataStreamImpl(
      bluetoothModule: BluetoothResource.bluetoothModule,
    );

    ApplicationPersist.init();
  }
}
