part of 'electrochemical_command_change_notifier.dart';

mixin AD5940 {
  void setAd5940ParametersElectrodes(Uint8List electrodes);
  Uint8List getAd5940ParametersElectrodes();
}
