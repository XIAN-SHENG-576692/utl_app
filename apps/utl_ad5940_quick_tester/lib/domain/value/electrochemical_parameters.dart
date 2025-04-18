import 'package:equatable/equatable.dart';
import 'package:utl_ad5940_quick_tester/domain/value/ad5940_handler.dart';

enum ElectrochemicalType {
  ca,
  cv,
  dpv,
}

abstract class ElectrochemicalParameters {
  ElectrochemicalType get type;
}

class CaElectrochemicalParameters extends Equatable implements ElectrochemicalParameters {
  final double eDc;
  final double tInterval;
  final double tRun;

  const CaElectrochemicalParameters({
    required this.eDc,
    required this.tInterval,
    required this.tRun,
  });

  @override
  ElectrochemicalType get type => ElectrochemicalType.ca;

  @override
  List<Object?> get props => [
    eDc,
    tInterval,
    tRun,
  ];

  int get stepNumberRamp {
    return (tRun / tInterval).floor();
  }

  Iterable<double> get times sync* {
    for(int index=0; index<stepNumberRamp; index++) {
      yield tInterval * index;
    }
  }

  Iterable<double> currents({
    required Iterable<int> adcData,
    required double adcPga,
    required double vRef1p82,
    required FImpPolType hsRTia,
  }) {
    return adcData.map((adc) {
      return ad5940AdcCode2Volt(adc & 0xFFFF, adcPga, vRef1p82) * 1e9 / hsRTia.magnitude;
    });
  }
}

class CvElectrochemicalParameters extends Equatable implements ElectrochemicalParameters {
  final double eBegin;
  final double eVertex1;
  final double eVertex2;
  final double eStep;
  final double scanRate;
  final int numberOfScans;

  const CvElectrochemicalParameters({
    required this.eBegin,
    required this.eVertex1,
    required this.eVertex2,
    required this.eStep,
    required this.scanRate,
    required this.numberOfScans,
  });

  @override
  ElectrochemicalType get type => ElectrochemicalType.cv;

  @override
  List<Object?> get props => [
    eBegin,
    eVertex1,
    eVertex2,
    eStep,
    scanRate,
    numberOfScans,
  ];

  double _eStepReal(double eBegin, double eEnd, double eStep) {
    return (eEnd > eBegin) ? eStep : -eStep;
  }

  int _stepNumberRamp(double eBegin, double eEnd, double eStep) {
    double total = (eEnd - eBegin).abs() / eStep;
    double intPart = total.floorToDouble();
    double fraction = total - intPart;

    if (fraction > 1e-7) {
      return (intPart + 1).toInt();
    } else {
      return intPart.toInt();
    }
  }

  int get stepNumber {
    return _stepNumberRamp(eBegin, eVertex1, eStep) +
        _stepNumberRamp(eVertex1, eVertex2, eStep) +
        _stepNumberRamp(eVertex2, eBegin, eStep);
  }

  double _getVoltageAtIndex({
    required int index,
    required double eStepRealB1,
    required double eStepReal12,
    required double eStepReal2B,
    required int stepNumberB1,
    required int stepNumberB12,
    required int stepNumberB12B,
  }) {
    int position = index % stepNumberB12B;

    if (position < stepNumberB1) {
      return eBegin + (position * eStepRealB1);
    } else if (position < stepNumberB12) {
      return eVertex1 + ((position - stepNumberB1) * eStepReal12);
    } else {
      return eVertex2 + ((position - stepNumberB12) * eStepReal2B);
    }
  }

  Iterable<double> get voltages sync* {
    double eStepRealB1 = _eStepReal(
      eBegin,
      eVertex1,
      eStep,
    );
    double eStepReal12 = _eStepReal(
      eVertex1,
      eVertex2,
      eStep,
    );
    double eStepReal2B = _eStepReal(
      eVertex2,
      eBegin,
      eStep,
    );
    int stepNumberB1 = _stepNumberRamp(
      eBegin,
      eVertex1,
      eStep,
    );
    int stepNumberB12 = stepNumberB1 +
        _stepNumberRamp(
          eVertex1,
          eVertex2,
          eStep,
        );
    int stepNumberB12B = stepNumberB12 +
        _stepNumberRamp(
          eVertex2,
          eBegin,
          eStep,
        );
    for(int index=0; index<stepNumberB12B; index++) {
      yield _getVoltageAtIndex(index: index, eStepRealB1: eStepRealB1, eStepReal12: eStepReal12, eStepReal2B: eStepReal2B, stepNumberB1: stepNumberB1, stepNumberB12: stepNumberB12, stepNumberB12B: stepNumberB12B);
    }
  }

  Iterable<double> currents({
    required Iterable<int> adcData,
    required double adcPga,
    required double vRef1p82,
    required FImpPolType hsRTia,
  }) {
    return adcData.map((adc) {
      return ad5940AdcCode2Volt(adc & 0xFFFF, adcPga, vRef1p82) * 1e9 / hsRTia.magnitude;
    });
  }
}

class DpvElectrochemicalParameters extends Equatable implements ElectrochemicalParameters {
  final double eBegin;
  final double eEnd;
  final double eStep;
  final double ePulse;
  final double tPulse;
  final double scanRate;
  final DpvElectrochemicalParametersInversionOption inversionOption;

  const DpvElectrochemicalParameters({
    required this.eBegin,
    required this.eEnd,
    required this.eStep,
    required this.ePulse,
    required this.tPulse,
    required this.scanRate,
    required this.inversionOption,
  });

  @override
  ElectrochemicalType get type => ElectrochemicalType.dpv;

  @override
  List<Object?> get props => [
    eBegin,
    eEnd,
    eStep,
    ePulse,
    tPulse,
    scanRate,
    inversionOption,
  ];

  double get _eStepReal {
    return (eEnd > eBegin)
        ? eStep
        : -eStep;
  }

  double get _ePulseReal {
    switch (inversionOption) {
      case DpvElectrochemicalParametersInversionOption.none:
        return (eEnd > eBegin)
            ? ePulse
            : -ePulse;

      case DpvElectrochemicalParametersInversionOption.both:
        return (eEnd > eBegin)
            ? -ePulse
            : ePulse;

      case DpvElectrochemicalParametersInversionOption.cathodic:
        return ePulse;

      case DpvElectrochemicalParametersInversionOption.anodic:
        return -ePulse;
    }
  }

  int get stepNumber {
    final total = ((eEnd - eBegin).abs() / eStep);
    final intPart = total.truncateToDouble();
    return ((intPart + 1.0) * 2).toInt();
  }

  double _voltageAtIndex(
      int index,
  ) {
    final halfIndex = (index / 2).floor();
    return (index % 2 == 0)
        ? eBegin + (_eStepReal * halfIndex)
        : eBegin + _ePulseReal + (_eStepReal * halfIndex);
  }

  Iterable<double> get detailVoltages {
    return Iterable.generate(stepNumber, (index) => _voltageAtIndex(index));
  }

  Iterable<double> get voltages {
    return detailVoltages.indexed
      .where((entry) => entry.$1.isEven)
      .map((entry) => entry.$2);
  }

  Iterable<double> detailCurrents({
    required Iterable<int> adcData,
    required double adcPga,
    required double vRef1p82,
    required FImpPolType hsRTia,
  }) {
    return adcData.map((adc) {
      return ad5940AdcCode2Volt(adc & 0xFFFF, adcPga, vRef1p82) * 1e9 / hsRTia.magnitude;
    });
  }

  Iterable<double> currents({
    required Iterable<int> adcData,
    required double adcPga,
    required double vRef1p82,
    required FImpPolType hsRTia,
  }) sync* {
    final currents = detailCurrents(adcData: adcData, adcPga: adcPga, vRef1p82: vRef1p82, hsRTia: hsRTia);
    for (int i = 1; i < currents.length; i += 2) {
      final currentStep = currents.skip(i - 1).first;
      final currentPulse = currents.skip(i).first;
      yield currentPulse - currentStep;
    }
  }
}

enum DpvElectrochemicalParametersInversionOption {
  none,
  both,
  cathodic,
  anodic,
}
