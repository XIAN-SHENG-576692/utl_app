import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';
import 'package:hex_keyboard/hex_keyboard_manager.dart';
import 'package:provider/provider.dart';
import 'package:utl_ad5940_quick_tester/infrastructure/bluetooth/bluetooth_module.dart';
import 'package:utl_ad5940_quick_tester/init/application_persist.dart';
import 'package:utl_ad5940_quick_tester/init/resource/bluetooth_resource.dart';
import 'package:utl_ad5940_quick_tester/presentation/change_notifier/electrochemical/line_chart/electrochemical_line_chart_manager_change_notifier.dart';

import 'application/buffer_and_download_file.dart';
import 'init/initializer.dart';
import 'l10n/generated/app_localizations.dart';
import 'presentation/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Initializer initializer = Initializer();
  await initializer();
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: MultiProvider(
        providers: [
          Provider<BluetoothModule>(
            create: (_) => BluetoothResource.bluetoothModule,
          ),
          Provider<BufferAndDownloadFile>(
            create: (_) => ApplicationPersist.bufferAndDownloadFile,
          ),
          ChangeNotifierProvider(create: (_) => HexKeyboardManager()),
          ChangeNotifierProvider<BluetoothQuickConnectionScannerChangeNotifier>(
            create: (_) => BluetoothQuickConnectionScannerChangeNotifier(
              displayFilter: (device) => device.deviceName.isNotEmpty,
              startScanTimeout: const Duration(seconds: 5),
            ),
          ),
          ChangeNotifierProvider<ElectrochemicalLineChartManagerChangeNotifier>(
            create: (_) => ElectrochemicalLineChartManagerChangeNotifier(
              bufferAndDownloadFile: ApplicationPersist.bufferAndDownloadFile,
            ),
          ),
          ChangeNotifierProvider(create: (_) => BluetoothQuickConnectionScannerChangeNotifier(
            displayFilter: (ScanResultBuffer buffer) => buffer.deviceName.isNotEmpty,
            startScanTimeout: const Duration(seconds: 5),
          )),
        ],
        child: const HomeScreen(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
