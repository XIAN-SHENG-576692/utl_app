import 'dart:async';

import 'package:synchronized/synchronized.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';

import '../../../service/electrochemical/electrochemical_data_stream.dart';
import 'bluetooth_received_packet.dart';

abstract class BluetoothPacketHandler {
  void handleReceivedPacket({
    required BluetoothReceivedPacket packet,
  });
  Stream<ElectrochemicalDataStreamDto> get electrochemicalDataStream;
  Stream<ElectrochemicalHeader> get electrochemicalHeaderStream;
}

class BluetoothPacketHandlerImpl implements BluetoothPacketHandler {
  final Lock _packetsLock = Lock();
  BluetoothPacketHandlerImpl();
  @override
  void handleReceivedPacket({
    required BluetoothReceivedPacket packet,
  }) async {
    return _packetsLock.synchronized(() async {
      var headerBuffer = packet.mapToHeader();
      if(headerBuffer != null) _validPacketStreamController.add(headerBuffer);
      var dataBuffer = packet.mapToData();
      if(dataBuffer != null) _validPacketStreamController.add(dataBuffer);
      return;
    });
  }
  final StreamController _validPacketStreamController = StreamController.broadcast();
  void dispose() {
    _validPacketStreamController.close();
  }

  @override
  Stream<ElectrochemicalDataStreamDto> get electrochemicalDataStream =>
      _validPacketStreamController
          .stream
          .where((packet) => packet is ElectrochemicalDataStreamDto)
          .map((packet) => packet as ElectrochemicalDataStreamDto);

  @override
  Stream<ElectrochemicalHeader> get electrochemicalHeaderStream =>
      _validPacketStreamController
          .stream
          .where((packet) => packet is ElectrochemicalHeader)
          .map((packet) => packet as ElectrochemicalHeader);
}
