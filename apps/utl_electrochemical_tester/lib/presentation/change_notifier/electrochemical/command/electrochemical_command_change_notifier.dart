import 'dart:typed_data';

import 'package:flutter/widgets.dart' show ChangeNotifier;

import '../../../../domain/entity/electrochemical_entity.dart';
import '../../../../service/electrochemical/electrochemical_devices_manager.dart';
import '../../../../service/local_storage/electrochemical_command_local_storage_handler.dart';

part 'ad5940.dart';
part 'title.dart';
part 'parameters/ca.dart';
part 'parameters/cv.dart';
part 'parameters/dpv.dart';

class ElectrochemicalCommandChangeNotifier extends ChangeNotifier with AD5940, Title, Ca, Cv, Dpv {
  final ElectrochemicalDevicesManager electrochemicalDevicesManager;
  final ElectrochemicalCommandLocalStorageHandler electrochemicalCommandLocalStorageHandler;
  ElectrochemicalCommandChangeNotifier({
      required this.electrochemicalDevicesManager,
      required this.electrochemicalCommandLocalStorageHandler,
  });

  @override
  Uint8List getAd5940ParametersElectrodes() {
    return electrochemicalCommandLocalStorageHandler.getAd5940ParametersElectrodes();
  }

  @override
  double getCaElectrochemicalParametersEDc() {
    return electrochemicalCommandLocalStorageHandler.getCaElectrochemicalParametersEDc();
  }

  @override
  double getCaElectrochemicalParametersTInterval() {
    return electrochemicalCommandLocalStorageHandler.getCaElectrochemicalParametersTInterval();
  }

  @override
  double getCaElectrochemicalParametersTRun() {
    return electrochemicalCommandLocalStorageHandler.getCaElectrochemicalParametersTRun();
  }

  @override
  int getCommandTabIndexBuffer() {
    return electrochemicalCommandLocalStorageHandler.getCommandTabIndexBuffer();
  }

  @override
  double getCvElectrochemicalParametersEBegin() {
    return electrochemicalCommandLocalStorageHandler.getCvElectrochemicalParametersEBegin();
  }

  @override
  double getCvElectrochemicalParametersEStep() {
    return electrochemicalCommandLocalStorageHandler.getCvElectrochemicalParametersEStep();
  }

  @override
  double getCvElectrochemicalParametersEVertex1() {
    return electrochemicalCommandLocalStorageHandler.getCvElectrochemicalParametersEVertex1();
  }

  @override
  double getCvElectrochemicalParametersEVertex2() {
    return electrochemicalCommandLocalStorageHandler.getCvElectrochemicalParametersEVertex2();
  }

  @override
  int getCvElectrochemicalParametersNumberOfScans() {
    return electrochemicalCommandLocalStorageHandler.getCvElectrochemicalParametersNumberOfScans();
  }

  @override
  double getCvElectrochemicalParametersScanRate() {
    return electrochemicalCommandLocalStorageHandler.getCvElectrochemicalParametersScanRate();
  }

  @override
  String getDataNameBuffer() {
    return electrochemicalCommandLocalStorageHandler.getDataNameBuffer();
  }

  @override
  double getDpvElectrochemicalParametersEBegin() {
    return electrochemicalCommandLocalStorageHandler.getDpvElectrochemicalParametersEBegin();
  }

  @override
  double getDpvElectrochemicalParametersEEnd() {
    return electrochemicalCommandLocalStorageHandler.getDpvElectrochemicalParametersEEnd();
  }

  @override
  double getDpvElectrochemicalParametersEPulse() {
    return electrochemicalCommandLocalStorageHandler.getDpvElectrochemicalParametersEPulse();
  }

  @override
  double getDpvElectrochemicalParametersEStep() {
    return electrochemicalCommandLocalStorageHandler.getDpvElectrochemicalParametersEStep();
  }

  @override
  DpvElectrochemicalParametersInversionOption getDpvElectrochemicalParametersInversionOption() {
    return electrochemicalCommandLocalStorageHandler.getDpvElectrochemicalParametersInversionOption();
  }

  @override
  double getDpvElectrochemicalParametersScanRate() {
    return electrochemicalCommandLocalStorageHandler.getDpvElectrochemicalParametersScanRate();
  }

  @override
  double getDpvElectrochemicalParametersTPulse() {
    return electrochemicalCommandLocalStorageHandler.getDpvElectrochemicalParametersTPulse();
  }

  @override
  void setAd5940ParametersElectrodes(Uint8List electrodes) {
    electrochemicalCommandLocalStorageHandler.setAd5940ParametersElectrodes(electrodes);
  }

  @override
  void setCaElectrochemicalParametersEDc(double eDc) {
    electrochemicalCommandLocalStorageHandler.setCaElectrochemicalParametersEDc(eDc);
  }

  @override
  void setCaElectrochemicalParametersTInterval(double tInterval) {
    electrochemicalCommandLocalStorageHandler.setCaElectrochemicalParametersTInterval(tInterval);
  }

  @override
  void setCaElectrochemicalParametersTRun(double tRun) {
    electrochemicalCommandLocalStorageHandler.setCaElectrochemicalParametersTRun(tRun);
  }

  @override
  void setCommandTabIndexBuffer(int index) {
    electrochemicalCommandLocalStorageHandler.setCommandTabIndexBuffer(index);
  }

  @override
  void setCvElectrochemicalParametersEBegin(double eBegin) {
    electrochemicalCommandLocalStorageHandler.setCvElectrochemicalParametersEBegin(eBegin);
  }

  @override
  void setCvElectrochemicalParametersEStep(double eStep) {
    electrochemicalCommandLocalStorageHandler.setCvElectrochemicalParametersEStep(eStep);
  }

  @override
  void setCvElectrochemicalParametersEVertex1(double eVertex1) {
    electrochemicalCommandLocalStorageHandler.setCvElectrochemicalParametersEVertex1(eVertex1);
  }

  @override
  void setCvElectrochemicalParametersEVertex2(double eVertex2) {
    electrochemicalCommandLocalStorageHandler.setCvElectrochemicalParametersEVertex2(eVertex2);
  }

  @override
  void setCvElectrochemicalParametersNumberOfScans(int numberOfScans) {
    electrochemicalCommandLocalStorageHandler.setCvElectrochemicalParametersNumberOfScans(numberOfScans);
  }

  @override
  void setCvElectrochemicalParametersScanRate(double scanRate) {
    electrochemicalCommandLocalStorageHandler.setCvElectrochemicalParametersScanRate(scanRate);
  }

  @override
  void setDataNameBuffer(String dataName) {
    electrochemicalCommandLocalStorageHandler.setDataNameBuffer(dataName);
  }

  @override
  void setDpvElectrochemicalParametersEBegin(double eBegin) {
    electrochemicalCommandLocalStorageHandler.setDpvElectrochemicalParametersEBegin(eBegin);
  }

  @override
  void setDpvElectrochemicalParametersEEnd(double eEnd) {
    electrochemicalCommandLocalStorageHandler.setDpvElectrochemicalParametersEEnd(eEnd);
  }

  @override
  void setDpvElectrochemicalParametersEPulse(double ePulse) {
    electrochemicalCommandLocalStorageHandler.setDpvElectrochemicalParametersEPulse(ePulse);
  }

  @override
  void setDpvElectrochemicalParametersEStep(double eStep) {
    electrochemicalCommandLocalStorageHandler.setDpvElectrochemicalParametersEStep(eStep);
  }

  @override
  void setDpvElectrochemicalParametersInversionOption(DpvElectrochemicalParametersInversionOption inversionOption) {
    electrochemicalCommandLocalStorageHandler.setDpvElectrochemicalParametersInversionOption(inversionOption);
  }

  @override
  void setDpvElectrochemicalParametersScanRate(double scanRate) {
    electrochemicalCommandLocalStorageHandler.setDpvElectrochemicalParametersScanRate(scanRate);
  }

  @override
  void setDpvElectrochemicalParametersTPulse(double tPulse) {
    electrochemicalCommandLocalStorageHandler.setDpvElectrochemicalParametersTPulse(tPulse);
  }

  @override
  Future<void> start({
      required ElectrochemicalType type,
  }) async {
    ElectrochemicalParameters parameters;
    switch(type) {
      case ElectrochemicalType.ca:
        parameters = CaElectrochemicalParameters(
            eDc: getCaElectrochemicalParametersEDc(),
            tInterval: getCaElectrochemicalParametersTInterval(),
            tRun: getCaElectrochemicalParametersTRun(),
        );
      case ElectrochemicalType.cv:
        parameters = CvElectrochemicalParameters(
            eBegin: getCvElectrochemicalParametersEBegin(),
            eVertex1: getCvElectrochemicalParametersEVertex1(),
            eVertex2: getCvElectrochemicalParametersEVertex2(),
            eStep: getCvElectrochemicalParametersEStep(),
            scanRate: getCvElectrochemicalParametersScanRate(),
            numberOfScans: getCvElectrochemicalParametersNumberOfScans(),
        );
      case ElectrochemicalType.dpv:
        parameters = DpvElectrochemicalParameters(
            eBegin: getDpvElectrochemicalParametersEBegin(),
            eEnd: getDpvElectrochemicalParametersEEnd(),
            eStep: getDpvElectrochemicalParametersEStep(),
            ePulse: getDpvElectrochemicalParametersEPulse(),
            tPulse: getDpvElectrochemicalParametersTPulse(),
            scanRate: getDpvElectrochemicalParametersScanRate(),
            inversionOption: getDpvElectrochemicalParametersInversionOption(),
        );
    }
    for(final device in electrochemicalDevicesManager.devices) {
      await device.start(
        dataName: getDataNameBuffer(),
        electrodes: getAd5940ParametersElectrodes(),
        parameters: parameters,
      );
    }
    return;
  }

  @override
  Future<void> stop() async {
    for(final device in electrochemicalDevicesManager.devices) {
      await device.stop();
    }
  }
}
