part of '../../entity/electrochemical_entity.dart';

@HiveType(typeId: 5)
enum DpvElectrochemicalParametersInversionOption {
  @HiveField(0)
  none,
  @HiveField(1)
  both,
  @HiveField(2)
  cathodic,
  @HiveField(3)
  anodic,
}

@CopyWith()
@HiveType(typeId: 6)
@JsonSerializable()
class DpvElectrochemicalParameters with EquatableMixin implements ElectrochemicalParameters {
  @HiveField(0)
  final double eBegin;
  @HiveField(1)
  final double eEnd;
  @HiveField(2)
  final double eStep;
  @HiveField(3)
  final double ePulse;
  @HiveField(4)
  final double tPulse;
  @HiveField(5)
  final double scanRate;
  @HiveField(6)
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
  List<Object?> get props => [
    eBegin,
    eEnd,
    eStep,
    ePulse,
    tPulse,
    scanRate,
    inversionOption,
  ];

  @override
  String toString() {
    return "$eBegin, $eEnd, $eStep, $ePulse, $tPulse, $scanRate, ${inversionOption.name}";
  }

  @override
  factory DpvElectrochemicalParameters.fromJson(Map<String, dynamic> json) => _$DpvElectrochemicalParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DpvElectrochemicalParametersToJson(this);

  @override
  ElectrochemicalType get type => ElectrochemicalType.dpv;

  @override
  int get dataLength => stepCount * 2;

  @override
  bool get isValid => eStep > 0.0
      && ePulse > 0.0
      && tPulse > 0.0
      && scanRate > 0.0;

  int get stepCount {
    if(!isValid) return 0;
    return ((eEnd - eBegin).abs() / eStep).floor() + 1;
  }

  Iterable<double> get baseVoltages sync* {
    if(!isValid) return;
    if (eEnd >= eBegin) {
      for (double v = eBegin; v <= eEnd; v += eStep) {
        yield double.parse(v.toStringAsFixed(6));
      }
    } else {
      for (double v = eBegin; v >= eEnd; v -= eStep) {
        yield double.parse(v.toStringAsFixed(6));
      }
    }
  }

  Iterable<double> get pulseVoltages {
    if(!isValid) return Iterable.empty();
    return baseVoltages.map((v) => v + ePulseDirectional);
  }

  Iterable<double> get appliedVoltages sync* {
    if(!isValid) return;
    final stepList = baseVoltages.toList(growable: false);
    final pulseList = pulseVoltages.toList(growable: false);
    for (int i = 0; i < stepCount; i++) {
      yield stepList.elementAt(i);
      yield pulseList.elementAt(i);
    }
  }

  double get ePulseDirectional {
    if(!isValid) return 0.0;
    switch(inversionOption) {
      case DpvElectrochemicalParametersInversionOption.none:
        return ((eEnd > eBegin) ? eStep : -eStep);
      case DpvElectrochemicalParametersInversionOption.both:
        return ((eEnd > eBegin) ? -eStep : eStep);
      case DpvElectrochemicalParametersInversionOption.cathodic:
        return eStep;
      case DpvElectrochemicalParametersInversionOption.anodic:
        return -eStep;
    }
  }
}
