import 'package:bluetooth_utils/presentation/theme/bluetooth_theme.dart';
import 'package:flutter/material.dart';
import 'package:hex_keyboard/hex_keyboard/hex_keyboard.dart';
import 'package:hex_keyboard/hex_keyboard/hex_keyboard_controller.dart';
import 'package:hex_keyboard/hex_keyboard/hex_keyboard_manager.dart';
import 'package:provider/provider.dart';

class BluetoothHexKeyboardView extends StatelessWidget {
  final Widget child;
  const BluetoothHexKeyboardView({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final active = context.select<HexKeyboardManager, HexKeyboardController?>((manager) => manager.active);
    final hasFocus = context.select<HexKeyboardManager, bool>((manager) => manager.hasFocus);
    final manager = context.read<HexKeyboardManager>();
    return PopScope(
      canPop: active == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && (active != null)) {
          manager.clearActive();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: child,
          ),
          (active == null || !hasFocus)
            ? Row()
            : HexKeyboard(
              manager: manager,
              enterIcon: Icon(
                Icons.bluetooth_searching,
                color: themeData.bluetoothColor,
              ),
            ),
        ],
      ),
    );
  }
}
