import 'dart:typed_data';

import 'package:common_utils/bytes.dart';
import 'package:common_utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entity/electrochemical_entity.dart';

class SharedPreferencesHandler {
  final SharedPreferences sharedPreferences;
  const SharedPreferencesHandler._({
    required this.sharedPreferences,
  });

  static Future<SharedPreferencesHandler> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return SharedPreferencesHandler._(
      sharedPreferences: sharedPreferences,
    );
  }

  static const String _electrochemicalCommandTabIndexBufferKey = "_electrochemicalCommandTabIndexBufferKey";
  Future<bool> setElectrochemicalCommandTabIndexBuffer(int index) => sharedPreferences.setInt(_electrochemicalCommandTabIndexBufferKey, index);
  int getElectrochemicalCommandTabIndexBuffer() => sharedPreferences.getInt(_electrochemicalCommandTabIndexBufferKey) ?? 0;

  static const _electrochemicalDataNameBufferKey = "_electrochemicalDataNameBufferKey";
  Future<bool> setElectrochemicalDataNameBuffer(String dataName) => sharedPreferences.setString(_electrochemicalDataNameBufferKey, dataName);
  String getElectrochemicalDataNameBuffer() => sharedPreferences.getString(_electrochemicalDataNameBufferKey) ?? "";

// Ad5940ParametersHsTiaRTia
  static const _ad5940ParametersElectrodesKey = "_ad5940ParametersElectrochemicalWorkingElectrodeKey";
  Future<bool> setAd5940ParametersElectrodes(Uint8List ad5940ParametersElectrodes) =>
      sharedPreferences.setString(_ad5940ParametersElectrodesKey, ad5940ParametersElectrodes.toByteStrings().join(""));
  Uint8List getAd5940ParametersElectrodes() {
    try {
      return sharedPreferences.getString(_ad5940ParametersElectrodesKey)?.hexToUint8List() ?? Uint8List.fromList([]);
    } catch(e) {
      return Uint8List.fromList([]);
    }
  }

// CaElectrochemicalParametersEDc
  static const _caElectrochemicalParametersEDcKey = "_caElectrochemicalParametersEDcKey";
  Future<bool> setCaElectrochemicalParametersEDc(double eDc) =>
      sharedPreferences.setDouble(_caElectrochemicalParametersEDcKey, eDc);
  double getCaElectrochemicalParametersEDc() =>
      sharedPreferences.getDouble(_caElectrochemicalParametersEDcKey) ?? 0;

// CaElectrochemicalParametersTInterval
  static const _caElectrochemicalParametersTIntervalKey = "_caElectrochemicalParametersTIntervalKey";
  Future<bool> setCaElectrochemicalParametersTInterval(double tInterval) =>
      sharedPreferences.setDouble(_caElectrochemicalParametersTIntervalKey, tInterval);
  double getCaElectrochemicalParametersTInterval() =>
      sharedPreferences.getDouble(_caElectrochemicalParametersTIntervalKey) ?? 0;

// CaElectrochemicalParametersTRun
  static const _caElectrochemicalParametersTRunKey = "_caElectrochemicalParametersTRunKey";
  Future<bool> setCaElectrochemicalParametersTRun(double tRun) =>
      sharedPreferences.setDouble(_caElectrochemicalParametersTRunKey, tRun);
  double getCaElectrochemicalParametersTRun() =>
      sharedPreferences.getDouble(_caElectrochemicalParametersTRunKey) ?? 0;

// CvElectrochemicalParametersEBegin
  static const _cvElectrochemicalParametersEBeginKey = "_cvElectrochemicalParametersEBeginKey";
  Future<bool> setCvElectrochemicalParametersEBegin(double eBegin) =>
      sharedPreferences.setDouble(_cvElectrochemicalParametersEBeginKey, eBegin);
  double getCvElectrochemicalParametersEBegin() =>
      sharedPreferences.getDouble(_cvElectrochemicalParametersEBeginKey) ?? 0;

// CvElectrochemicalParametersEVertex1
  static const _cvElectrochemicalParametersEVertex1Key = "_cvElectrochemicalParametersEVertex1Key";
  Future<bool> setCvElectrochemicalParametersEVertex1(double eVertex1) =>
      sharedPreferences.setDouble(_cvElectrochemicalParametersEVertex1Key, eVertex1);
  double getCvElectrochemicalParametersEVertex1() =>
      sharedPreferences.getDouble(_cvElectrochemicalParametersEVertex1Key) ?? 0;

// CvElectrochemicalParametersEVertex2
  static const _cvElectrochemicalParametersEVertex2Key = "_cvElectrochemicalParametersEVertex2Key";
  Future<bool> setCvElectrochemicalParametersEVertex2(double eVertex2) =>
      sharedPreferences.setDouble(_cvElectrochemicalParametersEVertex2Key, eVertex2);
  double getCvElectrochemicalParametersEVertex2() =>
      sharedPreferences.getDouble(_cvElectrochemicalParametersEVertex2Key) ?? 0;

// CvElectrochemicalParametersEStep
  static const _cvElectrochemicalParametersEStepKey = "_cvElectrochemicalParametersEStepKey";
  Future<bool> setCvElectrochemicalParametersEStep(double eStep) =>
      sharedPreferences.setDouble(_cvElectrochemicalParametersEStepKey, eStep);
  double getCvElectrochemicalParametersEStep() =>
      sharedPreferences.getDouble(_cvElectrochemicalParametersEStepKey) ?? 0;

// CvElectrochemicalParametersScanRate
  static const _cvElectrochemicalParametersScanRateKey = "_cvElectrochemicalParametersScanRateKey";
  Future<bool> setCvElectrochemicalParametersScanRate(double scanRate) =>
      sharedPreferences.setDouble(_cvElectrochemicalParametersScanRateKey, scanRate);
  double getCvElectrochemicalParametersScanRate() =>
      sharedPreferences.getDouble(_cvElectrochemicalParametersScanRateKey) ?? 0;

// CvElectrochemicalParametersNumberOfScans
  static const _cvElectrochemicalParametersNumberOfScansKey = "_cvElectrochemicalParametersNumberOfScansKey";
  Future<bool> setCvElectrochemicalParametersNumberOfScans(int numberOfScans) =>
      sharedPreferences.setInt(_cvElectrochemicalParametersNumberOfScansKey, numberOfScans);
  int getCvElectrochemicalParametersNumberOfScans() =>
      sharedPreferences.getInt(_cvElectrochemicalParametersNumberOfScansKey) ?? 0;

// DpvElectrochemicalParametersEBegin
  static const _dpvElectrochemicalParametersEBeginKey = "_dpvElectrochemicalParametersEBeginKey";
  Future<bool> setDpvElectrochemicalParametersEBegin(double eBegin) =>
      sharedPreferences.setDouble(_dpvElectrochemicalParametersEBeginKey, eBegin);
  double getDpvElectrochemicalParametersEBegin() =>
      sharedPreferences.getDouble(_dpvElectrochemicalParametersEBeginKey) ?? 0;

// DpvElectrochemicalParametersEEnd
  static const _dpvElectrochemicalParametersEEndKey = "_dpvElectrochemicalParametersEEndKey";
  Future<bool> setDpvElectrochemicalParametersEEnd(double eEnd) =>
      sharedPreferences.setDouble(_dpvElectrochemicalParametersEEndKey, eEnd);
  double getDpvElectrochemicalParametersEEnd() =>
      sharedPreferences.getDouble(_dpvElectrochemicalParametersEEndKey) ?? 0;

// DpvElectrochemicalParametersEStep
  static const _dpvElectrochemicalParametersEStepKey = "_dpvElectrochemicalParametersEStepKey";
  Future<bool> setDpvElectrochemicalParametersEStep(double eStep) =>
      sharedPreferences.setDouble(_dpvElectrochemicalParametersEStepKey, eStep);
  double getDpvElectrochemicalParametersEStep() =>
      sharedPreferences.getDouble(_dpvElectrochemicalParametersEStepKey) ?? 0;

// DpvElectrochemicalParametersEPulse
  static const _dpvElectrochemicalParametersEPulseKey = "_dpvElectrochemicalParametersEPulseKey";
  Future<bool> setDpvElectrochemicalParametersEPulse(double ePulse) =>
      sharedPreferences.setDouble(_dpvElectrochemicalParametersEPulseKey, ePulse);
  double getDpvElectrochemicalParametersEPulse() =>
      sharedPreferences.getDouble(_dpvElectrochemicalParametersEPulseKey) ?? 0;

// DpvElectrochemicalParametersTPulse
  static const _dpvElectrochemicalParametersTPulseKey = "_dpvElectrochemicalParametersTPulseKey";
  Future<bool> setDpvElectrochemicalParametersTPulse(double tPulse) =>
      sharedPreferences.setDouble(_dpvElectrochemicalParametersTPulseKey, tPulse);
  double getDpvElectrochemicalParametersTPulse() =>
      sharedPreferences.getDouble(_dpvElectrochemicalParametersTPulseKey) ?? 0;

// DpvElectrochemicalParametersScanRate
  static const _dpvElectrochemicalParametersScanRateKey = "_dpvElectrochemicalParametersScanRateKey";
  Future<bool> setDpvElectrochemicalParametersScanRate(double scanRate) =>
      sharedPreferences.setDouble(_dpvElectrochemicalParametersScanRateKey, scanRate);
  double getDpvElectrochemicalParametersScanRate() =>
      sharedPreferences.getDouble(_dpvElectrochemicalParametersScanRateKey) ?? 0;

// DpvElectrochemicalParametersInversionOption
  static const _dpvElectrochemicalParametersInversionOptionKey = "_dpvElectrochemicalParametersInversionOptionKey";
  Future<bool> setDpvElectrochemicalParametersInversionOption(DpvElectrochemicalParametersInversionOption inversionOption) =>
      sharedPreferences.setInt(_dpvElectrochemicalParametersInversionOptionKey, inversionOption.index);
  DpvElectrochemicalParametersInversionOption getDpvElectrochemicalParametersInversionOption() =>
      DpvElectrochemicalParametersInversionOption.values[(sharedPreferences.getInt(_dpvElectrochemicalParametersInversionOptionKey) ?? 0)];

}
