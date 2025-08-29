import 'dart:typed_data';

import 'package:utl_electrochemical_tester/infrastructure/source/shared_preferences/shared_preferences_handler.dart';

import '../../../domain/entity/electrochemical_entity.dart';
import '../../../service/local_storage/electrochemical_command_local_storage_handler.dart';

class ElectrochemicalCommandLocalStorageHandlerImpl implements ElectrochemicalCommandLocalStorageHandler {
  final SharedPreferencesHandler sharedPreferencesHandler;

  const ElectrochemicalCommandLocalStorageHandlerImpl({
    required this.sharedPreferencesHandler,
  });

  @override
  Uint8List getAd5940ParametersElectrodes() {
    return sharedPreferencesHandler.getAd5940ParametersElectrodes();
  }

  @override
  double getCaElectrochemicalParametersEDc() {
    return sharedPreferencesHandler.getCaElectrochemicalParametersEDc();
  }

  @override
  double getCaElectrochemicalParametersTInterval() {
    return sharedPreferencesHandler.getCaElectrochemicalParametersTInterval();
  }

  @override
  double getCaElectrochemicalParametersTRun() {
    return sharedPreferencesHandler.getCaElectrochemicalParametersTRun();
  }

  @override
  int getCommandTabIndexBuffer() {
    return sharedPreferencesHandler.getElectrochemicalCommandTabIndexBuffer();
  }

  @override
  double getCvElectrochemicalParametersEBegin() {
    return sharedPreferencesHandler.getCvElectrochemicalParametersEBegin();
  }

  @override
  double getCvElectrochemicalParametersEStep() {
    return sharedPreferencesHandler.getCvElectrochemicalParametersEStep();
  }

  @override
  double getCvElectrochemicalParametersEVertex1() {
    return sharedPreferencesHandler.getCvElectrochemicalParametersEVertex1();
  }

  @override
  double getCvElectrochemicalParametersEVertex2() {
    return sharedPreferencesHandler.getCvElectrochemicalParametersEVertex2();
  }

  @override
  int getCvElectrochemicalParametersNumberOfScans() {
    return sharedPreferencesHandler.getCvElectrochemicalParametersNumberOfScans();
  }

  @override
  double getCvElectrochemicalParametersScanRate() {
    return sharedPreferencesHandler.getCvElectrochemicalParametersScanRate();
  }

  @override
  String getDataNameBuffer() {
    return sharedPreferencesHandler.getElectrochemicalDataNameBuffer();
  }

  @override
  double getDpvElectrochemicalParametersEBegin() {
    return sharedPreferencesHandler.getDpvElectrochemicalParametersEBegin();
  }

  @override
  double getDpvElectrochemicalParametersEEnd() {
    return sharedPreferencesHandler.getDpvElectrochemicalParametersEEnd();
  }

  @override
  double getDpvElectrochemicalParametersEPulse() {
    return sharedPreferencesHandler.getDpvElectrochemicalParametersEPulse();
  }

  @override
  double getDpvElectrochemicalParametersEStep() {
    return sharedPreferencesHandler.getDpvElectrochemicalParametersEStep();
  }

  @override
  DpvElectrochemicalParametersInversionOption getDpvElectrochemicalParametersInversionOption() {
    return sharedPreferencesHandler.getDpvElectrochemicalParametersInversionOption();
  }

  @override
  double getDpvElectrochemicalParametersScanRate() {
    return sharedPreferencesHandler.getDpvElectrochemicalParametersScanRate();
  }

  @override
  double getDpvElectrochemicalParametersTPulse() {
    return sharedPreferencesHandler.getDpvElectrochemicalParametersTPulse();
  }

  @override
  void setAd5940ParametersElectrodes(Uint8List ad5940ParametersElectrochemicalWorkingElectrode) {
    sharedPreferencesHandler.setAd5940ParametersElectrodes(ad5940ParametersElectrochemicalWorkingElectrode);
  }

  @override
  void setCaElectrochemicalParametersEDc(double eDc) {
    sharedPreferencesHandler.setCaElectrochemicalParametersEDc(eDc);
  }

  @override
  void setCaElectrochemicalParametersTInterval(double tInterval) {
    sharedPreferencesHandler.setCaElectrochemicalParametersTInterval(tInterval);
  }

  @override
  void setCaElectrochemicalParametersTRun(double tRun) {
    sharedPreferencesHandler.setCaElectrochemicalParametersTRun(tRun);
  }

  @override
  void setCommandTabIndexBuffer(int index) {
    sharedPreferencesHandler.setElectrochemicalCommandTabIndexBuffer(index);
  }

  @override
  void setCvElectrochemicalParametersEBegin(double eBegin) {
    sharedPreferencesHandler.setCvElectrochemicalParametersEBegin(eBegin);
  }

  @override
  void setCvElectrochemicalParametersEStep(double eStep) {
    sharedPreferencesHandler.setCvElectrochemicalParametersEStep(eStep);
  }

  @override
  void setCvElectrochemicalParametersEVertex1(double eVertex1) {
    sharedPreferencesHandler.setCvElectrochemicalParametersEVertex1(eVertex1);
  }

  @override
  void setCvElectrochemicalParametersEVertex2(double eVertex2) {
    sharedPreferencesHandler.setCvElectrochemicalParametersEVertex2(eVertex2);
  }

  @override
  void setCvElectrochemicalParametersNumberOfScans(int numberOfScans) {
    sharedPreferencesHandler.setCvElectrochemicalParametersNumberOfScans(numberOfScans);
  }

  @override
  void setCvElectrochemicalParametersScanRate(double scanRate) {
    sharedPreferencesHandler.setCvElectrochemicalParametersScanRate(scanRate);
  }

  @override
  void setDataNameBuffer(String dataName) {
    sharedPreferencesHandler.setElectrochemicalDataNameBuffer(dataName);
  }

  @override
  void setDpvElectrochemicalParametersEBegin(double eBegin) {
    sharedPreferencesHandler.setDpvElectrochemicalParametersEBegin(eBegin);
  }

  @override
  void setDpvElectrochemicalParametersEEnd(double eEnd) {
    sharedPreferencesHandler.setDpvElectrochemicalParametersEEnd(eEnd);
  }

  @override
  void setDpvElectrochemicalParametersEPulse(double ePulse) {
    sharedPreferencesHandler.setDpvElectrochemicalParametersEPulse(ePulse);
  }

  @override
  void setDpvElectrochemicalParametersEStep(double eStep) {
    sharedPreferencesHandler.setDpvElectrochemicalParametersEStep(eStep);
  }

  @override
  void setDpvElectrochemicalParametersInversionOption(DpvElectrochemicalParametersInversionOption inversionOption) {
    sharedPreferencesHandler.setDpvElectrochemicalParametersInversionOption(inversionOption);
  }

  @override
  void setDpvElectrochemicalParametersScanRate(double scanRate) {
    sharedPreferencesHandler.setDpvElectrochemicalParametersScanRate(scanRate);
  }

  @override
  void setDpvElectrochemicalParametersTPulse(double tPulse) {
    sharedPreferencesHandler.setDpvElectrochemicalParametersTPulse(tPulse);
  }
}