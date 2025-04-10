import 'package:utl_seat_cushion/infrastructure/bluetooth/bluetooth_module.dart';

class BluetoothResource {
  BluetoothResource._();
  static final List<String> sentUuids = [
    "6e400002-b5a3-f393-e0a9-e50e24dcca9e",
  ];
  static final List<String> receivedUuids = [
    "6e400003-b5a3-f393-e0a9-e50e24dcca9e",
  ];
  static late final BluetoothModule bluetoothModule;
}