import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothQuickConnectionScannerChangeNotifier(
        displayFilter: (ScanResultBuffer buffer) => buffer.deviceName.isNotEmpty,
        startScanTimeout: const Duration(seconds: 5),
      ),
      child: BluetoothQuickConnectionScannerView(),
    );
  }
}
