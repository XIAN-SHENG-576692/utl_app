import 'dart:async';

import 'package:synchronized/synchronized.dart';

import '../../../domain/model/entity/seat_cushion_entity.dart';
import '../../../service/data_stream/seat_cushion_sensor.dart';
import '../../bluetooth/bluetooth_module.dart';
import 'bluetooth_packet_seat_cushion_buffer.dart';

class SeatCushionSensorDataStreamImpl implements SeatCushionSensorDataStream {
  final BluetoothModule bluetoothModule;
  late final StreamSubscription _subscription;
  Lock packetsLock = Lock();
  final StreamController<SeatCushionSensorData> _controller = StreamController.broadcast();
  SeatCushionSensorDataStreamImpl({
    required this.bluetoothModule,
  }) {
    _subscription = bluetoothModule.onReceive.listen((packet) {
      packetsLock.synchronized(() async {
        if(!_seatCushionDeviceIdWhitelist.contains(packet.deviceId)) _seatCushionDeviceIdWhitelist.add(packet.deviceId);
        var buffer = BluetoothPacketSeatCushionBuffer.create(packet: packet);
        if(buffer != null) {
          _buffers.add(buffer);
          await _handleSeatCushionDataStream();
          return;
        }
        return;
      });
    });
  }
  final List<String> _seatCushionDeviceIdWhitelist = [];
  final List<BluetoothPacketSeatCushionBuffer> _buffers = [];
  _handleSeatCushionDataStream() async {
    for(var id in _seatCushionDeviceIdWhitelist) {
      var targetIdDevices = _buffers.where((b) => b.deviceId == id);
      for(var type in SeatCushionType.values) {
        var targetIdTypeForcesStageDevices = BluetoothPacketDtoForcesStage
            .values
            .map((stage) => targetIdDevices.where((buffer) => buffer.seatCushionType == type && buffer.forcesStage == stage));
        bool flag = true;
        for(var l in targetIdTypeForcesStageDevices) {
          if(l.isEmpty) {
            flag = false;
            break;
          }
        }
        if(!flag) continue;
        var forces = _sortForces(
          type: type,
          forces: targetIdTypeForcesStageDevices
            .map((l) => l.first.partForces)
            .fold(<int>[], (previousValue, element) => previousValue..addAll(element)),
        );
        _controller.add(
          SeatCushionSensorData(
            deviceId: id,
            forces: forces,
            type: type,
          ),
        );
        _buffers.removeWhere(targetIdDevices.contains);
      }
    }
  }
  List<int> _sortForces({
    required SeatCushionType type,
    required List<int> forces,
  }) {
    switch(type) {
      case SeatCushionType.upper:
        return forces.reversed.toList(growable: false);
      case SeatCushionType.lower:
        return forces.toList(growable: false);
    }
  }
  @override
  Stream<SeatCushionSensorData> get seatCushionSensorDataStream => _controller.stream;
  @override
  @pragma('vm:notify-debugger-on-exception')
  void mockData({
    required SeatCushionSensorData data,
  }) {
    _controller.add(data);
  }
  void cancel() {
    _subscription.cancel();
    _controller.close();
  }
}
