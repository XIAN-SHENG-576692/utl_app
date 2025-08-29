part of '../entity/electrochemical_entity.dart';

enum ElectrochemicalType {
  ca,
  cv,
  dpv,
}

@CopyWith()
@HiveType(typeId: 1)
@JsonSerializable()
class ElectrochemicalHeader with EquatableMixin {
  @override
  @HiveField(0)
  final String dataName;
  @override
  @HiveField(1)
  final String deviceName;
  @override
  @HiveField(2)
  final String deviceId;
  @override
  @HiveField(3)
  final DateTime createdTime;
  @override
  @HiveField(4)
  final double temperature;
  @override
  @HiveField(5)
  final CaElectrochemicalParameters? caParameters;
  @override
  @HiveField(6)
  final CvElectrochemicalParameters? cvParameters;
  @override
  @HiveField(7)
  final DpvElectrochemicalParameters? dpvParameters;

  const ElectrochemicalHeader._({
    required this.dataName,
    required this.deviceName,
    required this.deviceId,
    required this.createdTime,
    required this.temperature,
    this.caParameters,
    this.cvParameters,
    this.dpvParameters,
  });

  factory ElectrochemicalHeader({
    required String dataName,
    required String deviceName,
    required String deviceId,
    required DateTime createdTime,
    required double temperature,
    CaElectrochemicalParameters? caParameters,
    CvElectrochemicalParameters? cvParameters,
    DpvElectrochemicalParameters? dpvParameters,
  })
  {
    final parametersList = [caParameters, cvParameters, dpvParameters];
    if(parametersList.where((p) => p != null).length != 1) throw ArgumentError("Only allow one parameters.");
    if(caParameters != null) {
      return ElectrochemicalHeader._(dataName: dataName, deviceName: deviceName, deviceId: deviceId, createdTime: createdTime, temperature: temperature, caParameters: caParameters);
    }
    if(cvParameters != null) {
      return ElectrochemicalHeader._(dataName: dataName, deviceName: deviceName, deviceId: deviceId, createdTime: createdTime, temperature: temperature, cvParameters: cvParameters);
    }
    if(dpvParameters != null) {
      return ElectrochemicalHeader._(dataName: dataName, deviceName: deviceName, deviceId: deviceId, createdTime: createdTime, temperature: temperature, dpvParameters: dpvParameters);
    }
    throw UnimplementedError();
  }

  factory ElectrochemicalHeader.createWithoutError({
    required String dataName,
    required String deviceName,
    required String deviceId,
    required DateTime createdTime,
    required double temperature,
    required ElectrochemicalParameters parameters,
  })
  {
    return ElectrochemicalHeader(
      dataName: dataName,
      deviceName: deviceName,
      deviceId: deviceId,
      createdTime: createdTime,
      temperature: temperature,
      caParameters: (parameters is CaElectrochemicalParameters) ? parameters : null,
      cvParameters: (parameters is CvElectrochemicalParameters) ? parameters : null,
      dpvParameters: (parameters is DpvElectrochemicalParameters) ? parameters : null,
    );
  }

  ElectrochemicalType get type => parameters.type;
  ElectrochemicalParameters get parameters {
    if(caParameters != null) return caParameters!;
    if(cvParameters != null) return cvParameters!;
    if(dpvParameters != null) return dpvParameters!;
    throw ArgumentError("All of the parameters is null");
  }

  bool get isValid => parameters.isValid;
  int get dataLength => parameters.dataLength;

  @override
  List<Object?> get props => [
    dataName,
    deviceName,
    deviceId,
    createdTime,
    temperature,
    caParameters,
    cvParameters,
    dpvParameters,
  ];

  @override
  factory ElectrochemicalHeader.fromJson(Map<String, dynamic> json) => _$ElectrochemicalHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$ElectrochemicalHeaderToJson(this);
}
