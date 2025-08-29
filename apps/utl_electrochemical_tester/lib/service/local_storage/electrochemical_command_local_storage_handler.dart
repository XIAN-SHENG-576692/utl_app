import 'dart:typed_data';

import '../../domain/entity/electrochemical_entity.dart';

abstract class ElectrochemicalCommandLocalStorageHandler {
  void setCommandTabIndexBuffer(int index);
  int getCommandTabIndexBuffer();

  void setDataNameBuffer(String dataName);
  String getDataNameBuffer();

  void setAd5940ParametersElectrodes(Uint8List electrodes);
  Uint8List getAd5940ParametersElectrodes();

  void setCaElectrochemicalParametersEDc(double eDc);
  double getCaElectrochemicalParametersEDc();

  void setCaElectrochemicalParametersTInterval(double tInterval);
  double getCaElectrochemicalParametersTInterval();

  void setCaElectrochemicalParametersTRun(double tRun);
  double getCaElectrochemicalParametersTRun();

  void setCvElectrochemicalParametersEBegin(double eBegin);
  double getCvElectrochemicalParametersEBegin();

  void setCvElectrochemicalParametersEVertex1(double eVertex1);
  double getCvElectrochemicalParametersEVertex1();

  void setCvElectrochemicalParametersEVertex2(double eVertex2);
  double getCvElectrochemicalParametersEVertex2();

  void setCvElectrochemicalParametersEStep(double eStep);
  double getCvElectrochemicalParametersEStep();

  void setCvElectrochemicalParametersScanRate(double scanRate);
  double getCvElectrochemicalParametersScanRate();

  void setCvElectrochemicalParametersNumberOfScans(int numberOfScans);
  int getCvElectrochemicalParametersNumberOfScans();

  void setDpvElectrochemicalParametersEBegin(double eBegin);
  double getDpvElectrochemicalParametersEBegin();

  void setDpvElectrochemicalParametersEEnd(double eEnd);
  double getDpvElectrochemicalParametersEEnd();

  void setDpvElectrochemicalParametersEStep(double eStep);
  double getDpvElectrochemicalParametersEStep();

  void setDpvElectrochemicalParametersEPulse(double ePulse);
  double getDpvElectrochemicalParametersEPulse();

  void setDpvElectrochemicalParametersTPulse(double tPulse);
  double getDpvElectrochemicalParametersTPulse();

  void setDpvElectrochemicalParametersScanRate(double scanRate);
  double getDpvElectrochemicalParametersScanRate();

  void setDpvElectrochemicalParametersInversionOption(DpvElectrochemicalParametersInversionOption inversionOption);
  DpvElectrochemicalParametersInversionOption getDpvElectrochemicalParametersInversionOption();
}