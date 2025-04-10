part of '../_.dart';

mixin Dpv {
  void setDpvElectrochemicalParametersEBegin(String eBegin);
  String getDpvElectrochemicalParametersEBegin();

  void setDpvElectrochemicalParametersEEnd(String eEnd);
  String getDpvElectrochemicalParametersEEnd();

  void setDpvElectrochemicalParametersEStep(String eStep);
  String getDpvElectrochemicalParametersEStep();

  void setDpvElectrochemicalParametersEPulse(String ePulse);
  String getDpvElectrochemicalParametersEPulse();

  void setDpvElectrochemicalParametersTPulse(String tPulse);
  String getDpvElectrochemicalParametersTPulse();

  void setDpvElectrochemicalParametersScanRate(String scanRate);
  String getDpvElectrochemicalParametersScanRate();

  void setDpvElectrochemicalParametersInversionOption(DpvElectrochemicalParametersInversionOption inversionOption);
  DpvElectrochemicalParametersInversionOption getDpvElectrochemicalParametersInversionOption();
}
