import 'package:utl_electrochemical_tester/service/electrochemical/electrochemical_data_stream.dart';

import '../../../service/electrochemical/dto/electrochemical_device_received_dto.dart';
import '../../source/bluetooth/bluetooth_module.dart';

class ElectrochemicalDataStreamImpl implements ElectrochemicalDataStream {
  final BluetoothModule bluetoothModule;
  ElectrochemicalDataStreamImpl({
    required this.bluetoothModule,
  });

  @override
  Stream<ElectrochemicalDeviceReceivedDataDto> get dataStream => bluetoothModule.electrochemicalDataStream;

  @override
  Stream<ElectrochemicalDeviceReceivedHeaderDto> get headerStream => bluetoothModule.electrochemicalHeaderStream;
}
