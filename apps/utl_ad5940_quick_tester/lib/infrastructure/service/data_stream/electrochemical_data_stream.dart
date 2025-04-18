import 'dart:typed_data';

import 'package:common_utils/double.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/value/ad5940_handler.dart';
import '../../../domain/value/electrochemical_data.dart';
import '../../../domain/value/electrochemical_header.dart';
import '../../../domain/value/electrochemical_parameters.dart';
import '../../../service/data_stream/electrochemical_data_stream.dart';
import '../../bluetooth/bluetooth_module.dart';

class ElectrochemicalDataStreamImpl implements ElectrochemicalDataStream {
  BluetoothModule bluetoothModule;
  
  ElectrochemicalDataStreamImpl({
    required this.bluetoothModule,
  });

  ElectrochemicalParameters getParameters({
    required ElectrochemicalType type,
    required Uint8List bytes,
  }) {
    final parametersBytes = bytes.buffer.asFloat32List(0);
    switch(type) {
      case ElectrochemicalType.ca: {
        return CaElectrochemicalParameters(
          eDc: parametersBytes[0].toPrecision(4),
          tInterval: parametersBytes[1].toPrecision(4),
          tRun: parametersBytes[2].toPrecision(4),
        );
      }
      case ElectrochemicalType.cv:
        final numberOfScans = ByteData.view(bytes.sublist(4 * 5).buffer).getUint8(0);
        return CvElectrochemicalParameters(
          eBegin: parametersBytes[0].toPrecision(4),
          eVertex1: parametersBytes[1].toPrecision(4),
          eVertex2: parametersBytes[2].toPrecision(4),
          eStep: parametersBytes[3].toPrecision(4),
          scanRate: parametersBytes[4].toPrecision(4),
          numberOfScans: numberOfScans,
        );
      case ElectrochemicalType.dpv:
        final inversionOption = DpvElectrochemicalParametersInversionOption.values[ByteData.view(bytes.sublist(4 * 6).buffer).getUint8(0)];
        return DpvElectrochemicalParameters(
          eBegin: parametersBytes[0].toPrecision(4),
          eEnd: parametersBytes[1].toPrecision(4),
          eStep: parametersBytes[2].toPrecision(4),
          ePulse: parametersBytes[3].toPrecision(4),
          tPulse: parametersBytes[4].toPrecision(4),
          scanRate: parametersBytes[5].toPrecision(4),
          inversionOption: inversionOption,
        );
    }
  }

  @override
  Stream<ElectrochemicalData> get dataStream => bluetoothModule
    .onReceive.where((p) => p.data[0] == 0x02 && p.data[1] == 0x02)
    .map((p) {
      final startingBytesBuffer = ByteData.sublistView(p.data.buffer.asUint8List(2)).buffer;
      return ElectrochemicalData(
        adcData: ByteData.sublistView(startingBytesBuffer.asUint8List(0, 4)).getInt32(0),
      );
    });

  @override
  Stream<void> get endStream => bluetoothModule
    .onReceive.where((p) => p.data[0] == 0x02 && p.data[1] == 0x03);

  @override
  Stream<IdWithHeader> get headerStream => bluetoothModule
    .onReceive.where((p) => p.data[0] == 0x02 && p.data[1] == 0x01)
    .map((p) {
      final startingList = p.data.sublist(2);

      final idPtrEnd = 4;
      final typePtrEnd = idPtrEnd + 1;
      final parametersPtrEnd = typePtrEnd + 28;
      final temperaturePtrEnd = parametersPtrEnd + 4;
      final electrodeRoutingPtrEnd = temperaturePtrEnd + 4 * 4;
      final magnitudePtrEnd = electrodeRoutingPtrEnd + 4;
      final phasePtrEnd = magnitudePtrEnd + 4;
      final adcPgaPtrEnd = phasePtrEnd + 4;
      final vRef1p82PtrEnd = adcPgaPtrEnd + 4;

      final type = ElectrochemicalType.values[ByteData.view(startingList.sublist(typePtrEnd - 1).buffer).getUint8(0)];
      return IdWithHeader(
        id: ByteData.view(startingList.sublist(idPtrEnd - 4).buffer).getUint32(0),
        header: ElectrochemicalHeader(
          deviceName: p.deviceName,
          deviceId: p.deviceId,
          createdTime: DateTime.now(),
          parameters: getParameters(type: type, bytes: startingList.sublist(parametersPtrEnd - 28, parametersPtrEnd)),
          temperature: ByteData.view(startingList.sublist(temperaturePtrEnd - 4).buffer).getInt32(0, Endian.little) / 1e6,
          electrodeRouting: startingList.sublist(electrodeRoutingPtrEnd - 4*4, electrodeRoutingPtrEnd),
          hsRTia: FImpPolType(
            magnitude: ByteData.view(startingList.sublist(magnitudePtrEnd - 4).buffer).getFloat32(0, Endian.little).toPrecision(4),
            phase: ByteData.view(startingList.sublist(phasePtrEnd - 4).buffer).getFloat32(0, Endian.little).toPrecision(4),
          ),
          adcPga: ByteData.view(startingList.sublist(adcPgaPtrEnd - 4).buffer).getFloat32(0, Endian.little).toPrecision(4),
          vRef1p82: ByteData.view(startingList.sublist(vRef1p82PtrEnd - 4).buffer).getFloat32(0, Endian.little).toPrecision(4),
        ),
      );
    });
}