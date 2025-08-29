// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electrochemical_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ElectrochemicalEntityCWProxy {
  ElectrochemicalEntity id(int id);

  ElectrochemicalEntity header(ElectrochemicalHeader header);

  ElectrochemicalEntity data(List<ElectrochemicalData> data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ElectrochemicalEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ElectrochemicalEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ElectrochemicalEntity call({
    int id,
    ElectrochemicalHeader header,
    List<ElectrochemicalData> data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfElectrochemicalEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfElectrochemicalEntity.copyWith.fieldName(...)`
class _$ElectrochemicalEntityCWProxyImpl
    implements _$ElectrochemicalEntityCWProxy {
  const _$ElectrochemicalEntityCWProxyImpl(this._value);

  final ElectrochemicalEntity _value;

  @override
  ElectrochemicalEntity id(int id) => this(id: id);

  @override
  ElectrochemicalEntity header(ElectrochemicalHeader header) =>
      this(header: header);

  @override
  ElectrochemicalEntity data(List<ElectrochemicalData> data) =>
      this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ElectrochemicalEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ElectrochemicalEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ElectrochemicalEntity call({
    Object? id = const $CopyWithPlaceholder(),
    Object? header = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return ElectrochemicalEntity(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      header: header == const $CopyWithPlaceholder()
          ? _value.header
          // ignore: cast_nullable_to_non_nullable
          : header as ElectrochemicalHeader,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<ElectrochemicalData>,
    );
  }
}

extension $ElectrochemicalEntityCopyWith on ElectrochemicalEntity {
  /// Returns a callable class that can be used as follows: `instanceOfElectrochemicalEntity.copyWith(...)` or like so:`instanceOfElectrochemicalEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ElectrochemicalEntityCWProxy get copyWith =>
      _$ElectrochemicalEntityCWProxyImpl(this);
}

abstract class _$ElectrochemicalDataCWProxy {
  ElectrochemicalData data(double data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ElectrochemicalData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ElectrochemicalData(...).copyWith(id: 12, name: "My name")
  /// ````
  ElectrochemicalData call({
    double data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfElectrochemicalData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfElectrochemicalData.copyWith.fieldName(...)`
class _$ElectrochemicalDataCWProxyImpl implements _$ElectrochemicalDataCWProxy {
  const _$ElectrochemicalDataCWProxyImpl(this._value);

  final ElectrochemicalData _value;

  @override
  ElectrochemicalData data(double data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ElectrochemicalData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ElectrochemicalData(...).copyWith(id: 12, name: "My name")
  /// ````
  ElectrochemicalData call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return ElectrochemicalData(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as double,
    );
  }
}

extension $ElectrochemicalDataCopyWith on ElectrochemicalData {
  /// Returns a callable class that can be used as follows: `instanceOfElectrochemicalData.copyWith(...)` or like so:`instanceOfElectrochemicalData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ElectrochemicalDataCWProxy get copyWith =>
      _$ElectrochemicalDataCWProxyImpl(this);
}

abstract class _$ElectrochemicalHeaderCWProxy {
  ElectrochemicalHeader dataName(String dataName);

  ElectrochemicalHeader deviceName(String deviceName);

  ElectrochemicalHeader deviceId(String deviceId);

  ElectrochemicalHeader createdTime(DateTime createdTime);

  ElectrochemicalHeader temperature(double temperature);

  ElectrochemicalHeader caParameters(CaElectrochemicalParameters? caParameters);

  ElectrochemicalHeader cvParameters(CvElectrochemicalParameters? cvParameters);

  ElectrochemicalHeader dpvParameters(
      DpvElectrochemicalParameters? dpvParameters);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ElectrochemicalHeader(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ElectrochemicalHeader(...).copyWith(id: 12, name: "My name")
  /// ````
  ElectrochemicalHeader call({
    String dataName,
    String deviceName,
    String deviceId,
    DateTime createdTime,
    double temperature,
    CaElectrochemicalParameters? caParameters,
    CvElectrochemicalParameters? cvParameters,
    DpvElectrochemicalParameters? dpvParameters,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfElectrochemicalHeader.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfElectrochemicalHeader.copyWith.fieldName(...)`
class _$ElectrochemicalHeaderCWProxyImpl
    implements _$ElectrochemicalHeaderCWProxy {
  const _$ElectrochemicalHeaderCWProxyImpl(this._value);

  final ElectrochemicalHeader _value;

  @override
  ElectrochemicalHeader dataName(String dataName) => this(dataName: dataName);

  @override
  ElectrochemicalHeader deviceName(String deviceName) =>
      this(deviceName: deviceName);

  @override
  ElectrochemicalHeader deviceId(String deviceId) => this(deviceId: deviceId);

  @override
  ElectrochemicalHeader createdTime(DateTime createdTime) =>
      this(createdTime: createdTime);

  @override
  ElectrochemicalHeader temperature(double temperature) =>
      this(temperature: temperature);

  @override
  ElectrochemicalHeader caParameters(
          CaElectrochemicalParameters? caParameters) =>
      this(caParameters: caParameters);

  @override
  ElectrochemicalHeader cvParameters(
          CvElectrochemicalParameters? cvParameters) =>
      this(cvParameters: cvParameters);

  @override
  ElectrochemicalHeader dpvParameters(
          DpvElectrochemicalParameters? dpvParameters) =>
      this(dpvParameters: dpvParameters);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ElectrochemicalHeader(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ElectrochemicalHeader(...).copyWith(id: 12, name: "My name")
  /// ````
  ElectrochemicalHeader call({
    Object? dataName = const $CopyWithPlaceholder(),
    Object? deviceName = const $CopyWithPlaceholder(),
    Object? deviceId = const $CopyWithPlaceholder(),
    Object? createdTime = const $CopyWithPlaceholder(),
    Object? temperature = const $CopyWithPlaceholder(),
    Object? caParameters = const $CopyWithPlaceholder(),
    Object? cvParameters = const $CopyWithPlaceholder(),
    Object? dpvParameters = const $CopyWithPlaceholder(),
  }) {
    return ElectrochemicalHeader(
      dataName: dataName == const $CopyWithPlaceholder()
          ? _value.dataName
          // ignore: cast_nullable_to_non_nullable
          : dataName as String,
      deviceName: deviceName == const $CopyWithPlaceholder()
          ? _value.deviceName
          // ignore: cast_nullable_to_non_nullable
          : deviceName as String,
      deviceId: deviceId == const $CopyWithPlaceholder()
          ? _value.deviceId
          // ignore: cast_nullable_to_non_nullable
          : deviceId as String,
      createdTime: createdTime == const $CopyWithPlaceholder()
          ? _value.createdTime
          // ignore: cast_nullable_to_non_nullable
          : createdTime as DateTime,
      temperature: temperature == const $CopyWithPlaceholder()
          ? _value.temperature
          // ignore: cast_nullable_to_non_nullable
          : temperature as double,
      caParameters: caParameters == const $CopyWithPlaceholder()
          ? _value.caParameters
          // ignore: cast_nullable_to_non_nullable
          : caParameters as CaElectrochemicalParameters?,
      cvParameters: cvParameters == const $CopyWithPlaceholder()
          ? _value.cvParameters
          // ignore: cast_nullable_to_non_nullable
          : cvParameters as CvElectrochemicalParameters?,
      dpvParameters: dpvParameters == const $CopyWithPlaceholder()
          ? _value.dpvParameters
          // ignore: cast_nullable_to_non_nullable
          : dpvParameters as DpvElectrochemicalParameters?,
    );
  }
}

extension $ElectrochemicalHeaderCopyWith on ElectrochemicalHeader {
  /// Returns a callable class that can be used as follows: `instanceOfElectrochemicalHeader.copyWith(...)` or like so:`instanceOfElectrochemicalHeader.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ElectrochemicalHeaderCWProxy get copyWith =>
      _$ElectrochemicalHeaderCWProxyImpl(this);
}

abstract class _$CaElectrochemicalParametersCWProxy {
  CaElectrochemicalParameters eDc(double eDc);

  CaElectrochemicalParameters tInterval(double tInterval);

  CaElectrochemicalParameters tRun(double tRun);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CaElectrochemicalParameters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CaElectrochemicalParameters(...).copyWith(id: 12, name: "My name")
  /// ````
  CaElectrochemicalParameters call({
    double eDc,
    double tInterval,
    double tRun,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCaElectrochemicalParameters.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCaElectrochemicalParameters.copyWith.fieldName(...)`
class _$CaElectrochemicalParametersCWProxyImpl
    implements _$CaElectrochemicalParametersCWProxy {
  const _$CaElectrochemicalParametersCWProxyImpl(this._value);

  final CaElectrochemicalParameters _value;

  @override
  CaElectrochemicalParameters eDc(double eDc) => this(eDc: eDc);

  @override
  CaElectrochemicalParameters tInterval(double tInterval) =>
      this(tInterval: tInterval);

  @override
  CaElectrochemicalParameters tRun(double tRun) => this(tRun: tRun);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CaElectrochemicalParameters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CaElectrochemicalParameters(...).copyWith(id: 12, name: "My name")
  /// ````
  CaElectrochemicalParameters call({
    Object? eDc = const $CopyWithPlaceholder(),
    Object? tInterval = const $CopyWithPlaceholder(),
    Object? tRun = const $CopyWithPlaceholder(),
  }) {
    return CaElectrochemicalParameters(
      eDc: eDc == const $CopyWithPlaceholder()
          ? _value.eDc
          // ignore: cast_nullable_to_non_nullable
          : eDc as double,
      tInterval: tInterval == const $CopyWithPlaceholder()
          ? _value.tInterval
          // ignore: cast_nullable_to_non_nullable
          : tInterval as double,
      tRun: tRun == const $CopyWithPlaceholder()
          ? _value.tRun
          // ignore: cast_nullable_to_non_nullable
          : tRun as double,
    );
  }
}

extension $CaElectrochemicalParametersCopyWith on CaElectrochemicalParameters {
  /// Returns a callable class that can be used as follows: `instanceOfCaElectrochemicalParameters.copyWith(...)` or like so:`instanceOfCaElectrochemicalParameters.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CaElectrochemicalParametersCWProxy get copyWith =>
      _$CaElectrochemicalParametersCWProxyImpl(this);
}

abstract class _$CvElectrochemicalParametersCWProxy {
  CvElectrochemicalParameters eBegin(double eBegin);

  CvElectrochemicalParameters eVertex1(double eVertex1);

  CvElectrochemicalParameters eVertex2(double eVertex2);

  CvElectrochemicalParameters eStep(double eStep);

  CvElectrochemicalParameters scanRate(double scanRate);

  CvElectrochemicalParameters numberOfScans(int numberOfScans);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CvElectrochemicalParameters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CvElectrochemicalParameters(...).copyWith(id: 12, name: "My name")
  /// ````
  CvElectrochemicalParameters call({
    double eBegin,
    double eVertex1,
    double eVertex2,
    double eStep,
    double scanRate,
    int numberOfScans,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCvElectrochemicalParameters.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCvElectrochemicalParameters.copyWith.fieldName(...)`
class _$CvElectrochemicalParametersCWProxyImpl
    implements _$CvElectrochemicalParametersCWProxy {
  const _$CvElectrochemicalParametersCWProxyImpl(this._value);

  final CvElectrochemicalParameters _value;

  @override
  CvElectrochemicalParameters eBegin(double eBegin) => this(eBegin: eBegin);

  @override
  CvElectrochemicalParameters eVertex1(double eVertex1) =>
      this(eVertex1: eVertex1);

  @override
  CvElectrochemicalParameters eVertex2(double eVertex2) =>
      this(eVertex2: eVertex2);

  @override
  CvElectrochemicalParameters eStep(double eStep) => this(eStep: eStep);

  @override
  CvElectrochemicalParameters scanRate(double scanRate) =>
      this(scanRate: scanRate);

  @override
  CvElectrochemicalParameters numberOfScans(int numberOfScans) =>
      this(numberOfScans: numberOfScans);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CvElectrochemicalParameters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CvElectrochemicalParameters(...).copyWith(id: 12, name: "My name")
  /// ````
  CvElectrochemicalParameters call({
    Object? eBegin = const $CopyWithPlaceholder(),
    Object? eVertex1 = const $CopyWithPlaceholder(),
    Object? eVertex2 = const $CopyWithPlaceholder(),
    Object? eStep = const $CopyWithPlaceholder(),
    Object? scanRate = const $CopyWithPlaceholder(),
    Object? numberOfScans = const $CopyWithPlaceholder(),
  }) {
    return CvElectrochemicalParameters(
      eBegin: eBegin == const $CopyWithPlaceholder()
          ? _value.eBegin
          // ignore: cast_nullable_to_non_nullable
          : eBegin as double,
      eVertex1: eVertex1 == const $CopyWithPlaceholder()
          ? _value.eVertex1
          // ignore: cast_nullable_to_non_nullable
          : eVertex1 as double,
      eVertex2: eVertex2 == const $CopyWithPlaceholder()
          ? _value.eVertex2
          // ignore: cast_nullable_to_non_nullable
          : eVertex2 as double,
      eStep: eStep == const $CopyWithPlaceholder()
          ? _value.eStep
          // ignore: cast_nullable_to_non_nullable
          : eStep as double,
      scanRate: scanRate == const $CopyWithPlaceholder()
          ? _value.scanRate
          // ignore: cast_nullable_to_non_nullable
          : scanRate as double,
      numberOfScans: numberOfScans == const $CopyWithPlaceholder()
          ? _value.numberOfScans
          // ignore: cast_nullable_to_non_nullable
          : numberOfScans as int,
    );
  }
}

extension $CvElectrochemicalParametersCopyWith on CvElectrochemicalParameters {
  /// Returns a callable class that can be used as follows: `instanceOfCvElectrochemicalParameters.copyWith(...)` or like so:`instanceOfCvElectrochemicalParameters.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CvElectrochemicalParametersCWProxy get copyWith =>
      _$CvElectrochemicalParametersCWProxyImpl(this);
}

abstract class _$DpvElectrochemicalParametersCWProxy {
  DpvElectrochemicalParameters eBegin(double eBegin);

  DpvElectrochemicalParameters eEnd(double eEnd);

  DpvElectrochemicalParameters eStep(double eStep);

  DpvElectrochemicalParameters ePulse(double ePulse);

  DpvElectrochemicalParameters tPulse(double tPulse);

  DpvElectrochemicalParameters scanRate(double scanRate);

  DpvElectrochemicalParameters inversionOption(
      DpvElectrochemicalParametersInversionOption inversionOption);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DpvElectrochemicalParameters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DpvElectrochemicalParameters(...).copyWith(id: 12, name: "My name")
  /// ````
  DpvElectrochemicalParameters call({
    double eBegin,
    double eEnd,
    double eStep,
    double ePulse,
    double tPulse,
    double scanRate,
    DpvElectrochemicalParametersInversionOption inversionOption,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDpvElectrochemicalParameters.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDpvElectrochemicalParameters.copyWith.fieldName(...)`
class _$DpvElectrochemicalParametersCWProxyImpl
    implements _$DpvElectrochemicalParametersCWProxy {
  const _$DpvElectrochemicalParametersCWProxyImpl(this._value);

  final DpvElectrochemicalParameters _value;

  @override
  DpvElectrochemicalParameters eBegin(double eBegin) => this(eBegin: eBegin);

  @override
  DpvElectrochemicalParameters eEnd(double eEnd) => this(eEnd: eEnd);

  @override
  DpvElectrochemicalParameters eStep(double eStep) => this(eStep: eStep);

  @override
  DpvElectrochemicalParameters ePulse(double ePulse) => this(ePulse: ePulse);

  @override
  DpvElectrochemicalParameters tPulse(double tPulse) => this(tPulse: tPulse);

  @override
  DpvElectrochemicalParameters scanRate(double scanRate) =>
      this(scanRate: scanRate);

  @override
  DpvElectrochemicalParameters inversionOption(
          DpvElectrochemicalParametersInversionOption inversionOption) =>
      this(inversionOption: inversionOption);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DpvElectrochemicalParameters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DpvElectrochemicalParameters(...).copyWith(id: 12, name: "My name")
  /// ````
  DpvElectrochemicalParameters call({
    Object? eBegin = const $CopyWithPlaceholder(),
    Object? eEnd = const $CopyWithPlaceholder(),
    Object? eStep = const $CopyWithPlaceholder(),
    Object? ePulse = const $CopyWithPlaceholder(),
    Object? tPulse = const $CopyWithPlaceholder(),
    Object? scanRate = const $CopyWithPlaceholder(),
    Object? inversionOption = const $CopyWithPlaceholder(),
  }) {
    return DpvElectrochemicalParameters(
      eBegin: eBegin == const $CopyWithPlaceholder()
          ? _value.eBegin
          // ignore: cast_nullable_to_non_nullable
          : eBegin as double,
      eEnd: eEnd == const $CopyWithPlaceholder()
          ? _value.eEnd
          // ignore: cast_nullable_to_non_nullable
          : eEnd as double,
      eStep: eStep == const $CopyWithPlaceholder()
          ? _value.eStep
          // ignore: cast_nullable_to_non_nullable
          : eStep as double,
      ePulse: ePulse == const $CopyWithPlaceholder()
          ? _value.ePulse
          // ignore: cast_nullable_to_non_nullable
          : ePulse as double,
      tPulse: tPulse == const $CopyWithPlaceholder()
          ? _value.tPulse
          // ignore: cast_nullable_to_non_nullable
          : tPulse as double,
      scanRate: scanRate == const $CopyWithPlaceholder()
          ? _value.scanRate
          // ignore: cast_nullable_to_non_nullable
          : scanRate as double,
      inversionOption: inversionOption == const $CopyWithPlaceholder()
          ? _value.inversionOption
          // ignore: cast_nullable_to_non_nullable
          : inversionOption as DpvElectrochemicalParametersInversionOption,
    );
  }
}

extension $DpvElectrochemicalParametersCopyWith
    on DpvElectrochemicalParameters {
  /// Returns a callable class that can be used as follows: `instanceOfDpvElectrochemicalParameters.copyWith(...)` or like so:`instanceOfDpvElectrochemicalParameters.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DpvElectrochemicalParametersCWProxy get copyWith =>
      _$DpvElectrochemicalParametersCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ElectrochemicalEntityAdapter extends TypeAdapter<ElectrochemicalEntity> {
  @override
  final int typeId = 0;

  @override
  ElectrochemicalEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ElectrochemicalEntity(
      id: fields[0] as int,
      header: fields[1] as ElectrochemicalHeader,
      data: (fields[2] as List).cast<ElectrochemicalData>(),
    );
  }

  @override
  void write(BinaryWriter writer, ElectrochemicalEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.header)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectrochemicalEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ElectrochemicalDataAdapter extends TypeAdapter<ElectrochemicalData> {
  @override
  final int typeId = 2;

  @override
  ElectrochemicalData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ElectrochemicalData(
      data: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ElectrochemicalData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectrochemicalDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ElectrochemicalHeaderAdapter extends TypeAdapter<ElectrochemicalHeader> {
  @override
  final int typeId = 1;

  @override
  ElectrochemicalHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ElectrochemicalHeader(
      dataName: fields[0] as String,
      deviceName: fields[1] as String,
      deviceId: fields[2] as String,
      createdTime: fields[3] as DateTime,
      temperature: fields[4] as double,
      caParameters: fields[5] as CaElectrochemicalParameters?,
      cvParameters: fields[6] as CvElectrochemicalParameters?,
      dpvParameters: fields[7] as DpvElectrochemicalParameters?,
    );
  }

  @override
  void write(BinaryWriter writer, ElectrochemicalHeader obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dataName)
      ..writeByte(1)
      ..write(obj.deviceName)
      ..writeByte(2)
      ..write(obj.deviceId)
      ..writeByte(3)
      ..write(obj.createdTime)
      ..writeByte(4)
      ..write(obj.temperature)
      ..writeByte(5)
      ..write(obj.caParameters)
      ..writeByte(6)
      ..write(obj.cvParameters)
      ..writeByte(7)
      ..write(obj.dpvParameters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectrochemicalHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CaElectrochemicalParametersAdapter
    extends TypeAdapter<CaElectrochemicalParameters> {
  @override
  final int typeId = 3;

  @override
  CaElectrochemicalParameters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaElectrochemicalParameters(
      eDc: fields[0] as double,
      tInterval: fields[1] as double,
      tRun: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CaElectrochemicalParameters obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.eDc)
      ..writeByte(1)
      ..write(obj.tInterval)
      ..writeByte(2)
      ..write(obj.tRun);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaElectrochemicalParametersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CvElectrochemicalParametersAdapter
    extends TypeAdapter<CvElectrochemicalParameters> {
  @override
  final int typeId = 4;

  @override
  CvElectrochemicalParameters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CvElectrochemicalParameters(
      eBegin: fields[0] as double,
      eVertex1: fields[1] as double,
      eVertex2: fields[2] as double,
      eStep: fields[3] as double,
      scanRate: fields[4] as double,
      numberOfScans: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CvElectrochemicalParameters obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.eBegin)
      ..writeByte(1)
      ..write(obj.eVertex1)
      ..writeByte(2)
      ..write(obj.eVertex2)
      ..writeByte(3)
      ..write(obj.eStep)
      ..writeByte(4)
      ..write(obj.scanRate)
      ..writeByte(5)
      ..write(obj.numberOfScans);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CvElectrochemicalParametersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DpvElectrochemicalParametersAdapter
    extends TypeAdapter<DpvElectrochemicalParameters> {
  @override
  final int typeId = 6;

  @override
  DpvElectrochemicalParameters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DpvElectrochemicalParameters(
      eBegin: fields[0] as double,
      eEnd: fields[1] as double,
      eStep: fields[2] as double,
      ePulse: fields[3] as double,
      tPulse: fields[4] as double,
      scanRate: fields[5] as double,
      inversionOption: fields[6] as DpvElectrochemicalParametersInversionOption,
    );
  }

  @override
  void write(BinaryWriter writer, DpvElectrochemicalParameters obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.eBegin)
      ..writeByte(1)
      ..write(obj.eEnd)
      ..writeByte(2)
      ..write(obj.eStep)
      ..writeByte(3)
      ..write(obj.ePulse)
      ..writeByte(4)
      ..write(obj.tPulse)
      ..writeByte(5)
      ..write(obj.scanRate)
      ..writeByte(6)
      ..write(obj.inversionOption);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DpvElectrochemicalParametersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DpvElectrochemicalParametersInversionOptionAdapter
    extends TypeAdapter<DpvElectrochemicalParametersInversionOption> {
  @override
  final int typeId = 5;

  @override
  DpvElectrochemicalParametersInversionOption read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DpvElectrochemicalParametersInversionOption.none;
      case 1:
        return DpvElectrochemicalParametersInversionOption.both;
      case 2:
        return DpvElectrochemicalParametersInversionOption.cathodic;
      case 3:
        return DpvElectrochemicalParametersInversionOption.anodic;
      default:
        return DpvElectrochemicalParametersInversionOption.none;
    }
  }

  @override
  void write(
      BinaryWriter writer, DpvElectrochemicalParametersInversionOption obj) {
    switch (obj) {
      case DpvElectrochemicalParametersInversionOption.none:
        writer.writeByte(0);
        break;
      case DpvElectrochemicalParametersInversionOption.both:
        writer.writeByte(1);
        break;
      case DpvElectrochemicalParametersInversionOption.cathodic:
        writer.writeByte(2);
        break;
      case DpvElectrochemicalParametersInversionOption.anodic:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DpvElectrochemicalParametersInversionOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectrochemicalEntity _$ElectrochemicalEntityFromJson(
        Map<String, dynamic> json) =>
    ElectrochemicalEntity(
      id: (json['id'] as num).toInt(),
      header: ElectrochemicalHeader.fromJson(
          json['header'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => ElectrochemicalData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ElectrochemicalEntityToJson(
        ElectrochemicalEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'data': instance.data,
    };

ElectrochemicalData _$ElectrochemicalDataFromJson(Map<String, dynamic> json) =>
    ElectrochemicalData(
      data: (json['data'] as num).toDouble(),
    );

Map<String, dynamic> _$ElectrochemicalDataToJson(
        ElectrochemicalData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ElectrochemicalHeader _$ElectrochemicalHeaderFromJson(
        Map<String, dynamic> json) =>
    ElectrochemicalHeader(
      dataName: json['dataName'] as String,
      deviceName: json['deviceName'] as String,
      deviceId: json['deviceId'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      caParameters: json['caParameters'] == null
          ? null
          : CaElectrochemicalParameters.fromJson(
              json['caParameters'] as Map<String, dynamic>),
      cvParameters: json['cvParameters'] == null
          ? null
          : CvElectrochemicalParameters.fromJson(
              json['cvParameters'] as Map<String, dynamic>),
      dpvParameters: json['dpvParameters'] == null
          ? null
          : DpvElectrochemicalParameters.fromJson(
              json['dpvParameters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectrochemicalHeaderToJson(
        ElectrochemicalHeader instance) =>
    <String, dynamic>{
      'dataName': instance.dataName,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'createdTime': instance.createdTime.toIso8601String(),
      'temperature': instance.temperature,
      'caParameters': instance.caParameters,
      'cvParameters': instance.cvParameters,
      'dpvParameters': instance.dpvParameters,
    };

CaElectrochemicalParameters _$CaElectrochemicalParametersFromJson(
        Map<String, dynamic> json) =>
    CaElectrochemicalParameters(
      eDc: (json['eDc'] as num).toDouble(),
      tInterval: (json['tInterval'] as num).toDouble(),
      tRun: (json['tRun'] as num).toDouble(),
    );

Map<String, dynamic> _$CaElectrochemicalParametersToJson(
        CaElectrochemicalParameters instance) =>
    <String, dynamic>{
      'eDc': instance.eDc,
      'tInterval': instance.tInterval,
      'tRun': instance.tRun,
    };

CvElectrochemicalParameters _$CvElectrochemicalParametersFromJson(
        Map<String, dynamic> json) =>
    CvElectrochemicalParameters(
      eBegin: (json['eBegin'] as num).toDouble(),
      eVertex1: (json['eVertex1'] as num).toDouble(),
      eVertex2: (json['eVertex2'] as num).toDouble(),
      eStep: (json['eStep'] as num).toDouble(),
      scanRate: (json['scanRate'] as num).toDouble(),
      numberOfScans: (json['numberOfScans'] as num).toInt(),
    );

Map<String, dynamic> _$CvElectrochemicalParametersToJson(
        CvElectrochemicalParameters instance) =>
    <String, dynamic>{
      'eBegin': instance.eBegin,
      'eVertex1': instance.eVertex1,
      'eVertex2': instance.eVertex2,
      'eStep': instance.eStep,
      'scanRate': instance.scanRate,
      'numberOfScans': instance.numberOfScans,
    };

DpvElectrochemicalParameters _$DpvElectrochemicalParametersFromJson(
        Map<String, dynamic> json) =>
    DpvElectrochemicalParameters(
      eBegin: (json['eBegin'] as num).toDouble(),
      eEnd: (json['eEnd'] as num).toDouble(),
      eStep: (json['eStep'] as num).toDouble(),
      ePulse: (json['ePulse'] as num).toDouble(),
      tPulse: (json['tPulse'] as num).toDouble(),
      scanRate: (json['scanRate'] as num).toDouble(),
      inversionOption: $enumDecode(
          _$DpvElectrochemicalParametersInversionOptionEnumMap,
          json['inversionOption']),
    );

Map<String, dynamic> _$DpvElectrochemicalParametersToJson(
        DpvElectrochemicalParameters instance) =>
    <String, dynamic>{
      'eBegin': instance.eBegin,
      'eEnd': instance.eEnd,
      'eStep': instance.eStep,
      'ePulse': instance.ePulse,
      'tPulse': instance.tPulse,
      'scanRate': instance.scanRate,
      'inversionOption': _$DpvElectrochemicalParametersInversionOptionEnumMap[
          instance.inversionOption]!,
    };

const _$DpvElectrochemicalParametersInversionOptionEnumMap = {
  DpvElectrochemicalParametersInversionOption.none: 'none',
  DpvElectrochemicalParametersInversionOption.both: 'both',
  DpvElectrochemicalParametersInversionOption.cathodic: 'cathodic',
  DpvElectrochemicalParametersInversionOption.anodic: 'anodic',
};
