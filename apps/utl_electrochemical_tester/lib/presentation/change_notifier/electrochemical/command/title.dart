part of '_.dart';

mixin Title {
  Future<void> start({required ElectrochemicalType type});

  void setCommandTabIndexBuffer(int index);
  int getCommandTabIndexBuffer();

  void setDataNameBuffer(String dataName);
  String getDataNameBuffer();
}
