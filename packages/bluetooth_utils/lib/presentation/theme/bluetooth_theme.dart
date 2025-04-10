import 'package:flutter/material.dart';

extension BluetoothTheme on ThemeData {
  Color get bluetoothConnectionHighlightColor => scaffoldBackgroundColor;
  Color get bluetoothColor => brightness == Brightness.light
      ? Colors.blue
      : Colors.indigoAccent;
  Color get bluetoothConnectedDeviceTileColor => bluetoothColor;
  Color get bluetoothDisconnectedDeviceTileColor => brightness == Brightness.light
      ? Colors.red
      : Colors.red[900]!;
  Color get bluetoothStopScanningButtonColor => bluetoothDisconnectedDeviceTileColor;
}
