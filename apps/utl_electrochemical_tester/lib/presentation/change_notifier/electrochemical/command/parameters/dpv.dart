part of '../electrochemical_command_change_notifier.dart';

mixin Dpv {
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
