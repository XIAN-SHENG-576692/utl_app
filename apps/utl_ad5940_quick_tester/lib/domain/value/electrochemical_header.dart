import 'dart:typed_data';

import 'ad5940_handler.dart';
import 'electrochemical_parameters.dart';

class ElectrochemicalHeader {
  final String deviceName;
  final String deviceId;
  final DateTime createdTime;
  final ElectrochemicalParameters parameters;
  final double temperature;
  final Uint8List electrodeRouting;
  final FImpPolType hsRTia;
  final double adcPga;
  final double vRef1p82;
  CaElectrochemicalParameters? get caParameters => (parameters is CaElectrochemicalParameters) ? parameters as CaElectrochemicalParameters : null;
  CvElectrochemicalParameters? get cvParameters => (parameters is CvElectrochemicalParameters) ? parameters as CvElectrochemicalParameters : null;
  DpvElectrochemicalParameters? get dpvParameters => (parameters is DpvElectrochemicalParameters) ? parameters as DpvElectrochemicalParameters : null;

  ElectrochemicalType get type => parameters.type;

  ElectrochemicalHeader({
    required this.deviceName,
    required this.deviceId,
    required this.createdTime,
    required this.parameters,
    required this.temperature,
    required this.electrodeRouting,
    required this.hsRTia,
    required this.adcPga,
    required this.vRef1p82,
  });
}
