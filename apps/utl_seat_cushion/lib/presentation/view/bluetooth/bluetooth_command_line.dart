import 'package:bluetooth_utils/presentation/theme/bluetooth_theme.dart';
import 'package:flutter/material.dart';
import 'package:hex_keyboard/hex_keyboard/hex_keyboard_controller.dart';
import 'package:hex_keyboard/hex_keyboard/hex_keyboard_input_field.dart';
import 'package:hex_keyboard/hex_keyboard/hex_keyboard_manager.dart';
import 'package:provider/provider.dart';
import 'package:utl_seat_cushion/infrastructure/bluetooth/bluetooth_module.dart';

import '../../widget/widget_resources.dart';

class _ChangeNotifier with ChangeNotifier {
  @protected
  final BluetoothModule bluetoothModule;

  _ChangeNotifier({
    required this.bluetoothModule,
  }) {
    controller = HexKeyboardController(
      onEnter: (command) async {
        await bluetoothModule.sendCommand(command: command);
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

class _InitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return IconButton(
      onPressed: null,
      icon: WidgetResources.bluetoothInitIcon,
      color: themeData.bluetoothColor,
    );
  }
}

class BluetoothCommandLine extends StatelessWidget {
  const BluetoothCommandLine({super.key});
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
        return Row(
          children: [
            Expanded(
              child: HexKeyboardInputField(
                controller: notifier.controller,
                manager: manager
              ),
            ),
            _InitButton(),
          ],
        );
      },
    );
  }
}
