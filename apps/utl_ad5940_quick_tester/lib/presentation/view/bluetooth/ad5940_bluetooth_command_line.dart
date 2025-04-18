import 'dart:typed_data';

import 'package:common_utils/string.dart';
import 'package:flutter/material.dart';
import 'package:hex_keyboard/hex_keyboard_controller.dart';
import 'package:hex_keyboard/hex_keyboard_input_field.dart';
import 'package:hex_keyboard/hex_keyboard_manager.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/bluetooth/bluetooth_module.dart';

class _ChangeNotifier with ChangeNotifier {
  @protected
  final BluetoothModule bluetoothModule;

  _ChangeNotifier({
    required this.bluetoothModule,
  }) {
    controller = HexKeyboardController(
      onEnter: (command) async {
        final bytes = bluetoothModule.generateElectrochemicalCommand(bytes: command.hexToUint8List());
        await bluetoothModule.sendBytesToAllDevices(bytes: bytes);
        controller.clear();
      },
    );
  }

  late final HexKeyboardController controller;

  String get command => controller.text;

  void clear() {
    controller.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AD5940BluetoothCommandLine extends StatelessWidget {
  const AD5940BluetoothCommandLine({super.key});
  @override
  Widget build(BuildContext context) {
    final bluetoothModule = context.read<BluetoothModule>();
    return ChangeNotifierProvider(
      create: (_) => _ChangeNotifier(
        bluetoothModule: bluetoothModule,
      ),
      builder: (context, _) {
        final notifier = context.read<_ChangeNotifier>();
        final manager = context.read<HexKeyboardManager>();
        return HexKeyboardInputField(
          decoration: InputDecoration(hint: Text("Bluetooth Command")),
          controller: notifier.controller,
          manager: manager,
        );
      },
    );
  }
}
