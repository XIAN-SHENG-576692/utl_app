import 'dart:typed_data';

import '../../../domain/entity/electrochemical_entity.dart';

class BytesMapper {
  BytesMapper._();
  static const ELECTROCHEMICAL_PARAMETERS_LENGTH = 28;
  static ByteData mapElectrochemicalParametersToByteData({
    required ElectrochemicalParameters parameters,
    required bool align,
  }) {
    switch(parameters.type) {
      case ElectrochemicalType.ca:
        final temp = parameters as CaElectrochemicalParameters;
        return ByteData((align)
            ? ELECTROCHEMICAL_PARAMETERS_LENGTH
            : 12)
          ..setFloat32(0, temp.eDc, Endian.little)
          ..setFloat32(4, temp.tInterval, Endian.little)
          ..setFloat32(8, temp.tRun, Endian.little)
        ;
      case ElectrochemicalType.cv:
        final temp = parameters as CvElectrochemicalParameters;
        return ByteData((align)
            ? ELECTROCHEMICAL_PARAMETERS_LENGTH
            : 24)
          ..setFloat32(0, temp.eBegin, Endian.little)
          ..setFloat32(4, temp.eVertex1, Endian.little)
          ..setFloat32(8, temp.eVertex2, Endian.little)
          ..setFloat32(12, temp.eStep, Endian.little)
          ..setFloat32(16, temp.scanRate, Endian.little)
          ..setUint16(20, temp.numberOfScans, Endian.little)
        ;
      case ElectrochemicalType.dpv:
        final temp = parameters as DpvElectrochemicalParameters;
        return ByteData((align)
            ? ELECTROCHEMICAL_PARAMETERS_LENGTH
            : 28)
          ..setFloat32(0, temp.eBegin, Endian.little)
          ..setFloat32(4, temp.eEnd, Endian.little)
          ..setFloat32(8, temp.eStep, Endian.little)
          ..setFloat32(12, temp.ePulse, Endian.little)
          ..setFloat32(16, temp.tPulse, Endian.little)
          ..setFloat32(20, temp.scanRate, Endian.little)
          ..setUint8(24, temp.inversionOption.index)
        ;
    }
  }
}
