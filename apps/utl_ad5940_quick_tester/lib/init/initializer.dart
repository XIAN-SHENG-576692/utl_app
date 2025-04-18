import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_utils/path_provider_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utl_ad5940_quick_tester/infrastructure/bluetooth/bluetooth_module.dart';
import 'package:utl_ad5940_quick_tester/infrastructure/service/data_stream/electrochemical_data_stream.dart';
import 'package:utl_ad5940_quick_tester/init/resource/service_resource.dart';

import 'application_persist.dart';
import 'resource/bluetooth_resource.dart';
import 'resource/data_resource.dart';
import 'resource/path_resource.dart';

class Initializer {
  Future call() async {
    PathResource.downloadPath = ((await getSystemDownloadDirectory()) ?? (await getApplicationDocumentsDirectory())).absolute.path;

    FlutterBluePlus.setLogLevel(LogLevel.none);
    BluetoothResource.bluetoothModule = BluetoothModule();

    ServiceResource.electrochemicalDataStream = ElectrochemicalDataStreamImpl(bluetoothModule: BluetoothResource.bluetoothModule);

    DataResource.sharedPreferences = await SharedPreferences.getInstance();

    ApplicationPersist.init();
  }
}
