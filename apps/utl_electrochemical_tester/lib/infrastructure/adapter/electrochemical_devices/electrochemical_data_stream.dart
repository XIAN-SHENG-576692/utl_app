import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/service/electrochemical/electrochemical_data_stream.dart';

import '../../source/bluetooth/bluetooth_module.dart';

class ElectrochemicalDataStreamImpl implements ElectrochemicalStreamer {
  final BluetoothModule bluetoothModule;
  ElectrochemicalDataStreamImpl({
    required this.bluetoothModule,
  });

  @override
  Stream<ElectrochemicalDataStreamDto> get dataStream => bluetoothModule.electrochemicalDataStream;

  @override
  Stream<ElectrochemicalHeader> get headerStream => bluetoothModule.electrochemicalHeaderStream;
}
