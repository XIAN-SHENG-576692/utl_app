import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

import 'bluetooth_off_view.dart';

class BluetoothIsOnView extends StatelessWidget {
  final Widget isOnView;
  final Widget isOffView;
  BluetoothIsOnView({
    super.key,
    required this.isOnView,
    Widget? isOffView,
  }) : isOffView = isOffView ?? BluetoothOffView();
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (_) => FlutterBluePlus.adapterState,
      initialData: FlutterBluePlus.adapterStateNow,
      builder: (context, _) {
        final isOn = context.watch<BluetoothAdapterState>();
        return (isOn == BluetoothAdapterState.on)
          ? isOnView
          : isOffView;
      },
    );
  }
}
