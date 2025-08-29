part of 'electrochemical_command_change_notifier.dart';

mixin Title {
  void setCommandTabIndexBuffer(int index);
  int getCommandTabIndexBuffer();

  void setDataNameBuffer(String dataName);
  String getDataNameBuffer();

  Future<void> start({
    required ElectrochemicalType type,
  });

  Future<void> stop();
}
