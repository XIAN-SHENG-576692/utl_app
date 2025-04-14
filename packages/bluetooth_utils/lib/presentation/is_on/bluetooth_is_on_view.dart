import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

import '../others/bluetooth_off_view.dart';

/// A stateless widget that displays different views depending on Bluetooth status.
///
/// If Bluetooth is ON, it shows the [isOnView] widget.
/// If Bluetooth is OFF, it shows the [isOffView] widget, which defaults to [BluetoothOffView].
class BluetoothIsOnView extends StatelessWidget {
  /// Widget to display when Bluetooth is ON.
  final Widget isOnView;

  /// Widget to display when Bluetooth is OFF.
  /// Defaults to [BluetoothOffView] if not provided.
  final Widget isOffView;

  /// Constructor with required [isOnView] and optional [isOffView].
  /// If [isOffView] is not passed, it defaults to [BluetoothOffView].
  BluetoothIsOnView({
    super.key,
    required this.isOnView,
    Widget? isOffView,
  }) : isOffView = isOffView ?? BluetoothOffView();

  @override
  Widget build(BuildContext context) {
    // Provides the Bluetooth adapter state as a stream to the widget tree.
    // This allows for automatic UI updates when Bluetooth state changes.
    return StreamProvider<BluetoothAdapterState>(
      create: (_) => FlutterBluePlus.adapterState,
      initialData: FlutterBluePlus.adapterStateNow,
      builder: (context, _) {
        // Listens to the current Bluetooth state.
        final isOn = context.watch<BluetoothAdapterState>();

        // Renders the appropriate widget depending on whether Bluetooth is ON or OFF.
        return (isOn == BluetoothAdapterState.on)
            ? isOnView
            : isOffView;
      },
    );
  }
}
