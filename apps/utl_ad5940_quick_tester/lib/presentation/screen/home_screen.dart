import 'dart:math';

import 'package:bluetooth_utils/presentation/is_on/bluetooth_is_on_view.dart';
import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';

import '../view/bluetooth/ad5940_bluetooth_command_line.dart';
import '../view/bluetooth/bluetooth_hex_keyboard_view.dart';
import '../view/data_name_text.dart';
import '../view/electrochemical_line_chart/electrochemical_line_chart_features.dart';
import '../view/electrochemical_line_chart/electrochemical_line_chart_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final electrochemicalLineChartListView = ElectrochemicalLineChartListView();
    final electrochemicalLineChartFeatures = ElectrochemicalLineChartFeatures();
    final dataNameText = DataNameText();
    final ad5940BluetoothCommandLine = AD5940BluetoothCommandLine();
    final bluetoothQuickConnectionScannerView = BluetoothQuickConnectionScannerView();
    return BluetoothIsOnView(
      isOnView: Scaffold(
        body: SafeArea(
          child: BluetoothHexKeyboardView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final mediaQuery = MediaQuery.of(context);
                final controllerHeight = min(
                  constraints.maxHeight / 2,
                  constraints.maxHeight - mediaQuery.viewInsets.vertical,
                );
                return Column(
                  children: [
                    Expanded(
                      child: electrochemicalLineChartListView,
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                    ),
                    electrochemicalLineChartFeatures,
                    dataNameText,
                    ad5940BluetoothCommandLine,
                    Expanded(
                      child: SizedBox(
                        height: controllerHeight,
                        child: bluetoothQuickConnectionScannerView,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
