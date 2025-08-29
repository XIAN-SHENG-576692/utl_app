part of '../electrochemical_command_change_notifier.dart';

mixin Cv {
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
}
