import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_electrochemical_tester/infrastructure/presentation/change_notifier/electrochemical/electrochemical_line_chart_change_notifier.dart';
import 'package:utl_electrochemical_tester/init/initializer.dart';
import 'package:utl_electrochemical_tester/init/resource/infrastructure/path_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/data/repository_resource.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/command/electrochemical_command_change_notifier.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import 'package:utl_electrochemical_tester/presentation/screen/home_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'infrastructure/presentation/change_notifier/electrochemical/electrochemical_command_change_notifier.dart';
import 'infrastructure/presentation/change_notifier/electrochemical/electrochemical_feature_change_notifier.dart';
import 'init/resource/service/service_resource.dart';

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
          ChangeNotifierProvider<BluetoothQuickConnectionScannerChangeNotifier>(
            create: (_) => BluetoothQuickConnectionScannerChangeNotifier(
              displayFilter: (device) => device.deviceName.isNotEmpty,
              startScanTimeout: const Duration(seconds: 5),
            ),
          ),
          ChangeNotifierProvider<ElectrochemicalLineChartChangeNotifier>(
            create: (_) => ElectrochemicalLineChartChangeNotifierImpl(
              electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
            ),
          ),
          ChangeNotifierProvider<ElectrochemicalFeatureChangeNotifier>(
            create: (_) => ElectrochemicalFeatureChangeNotifierImpl(
              electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
              fileHandler: ServiceResource.fileHandler,
              folderPath: PathResource.downloadPath,
            ),
          ),
          ChangeNotifierProvider<ElectrochemicalCommandChangeNotifier>(
            create: (_) => ElectrochemicalCommandChangeNotifierImpl(
              electrochemicalDevicesManager: ServiceResource.electrochemicalDevicesManager,
              electrochemicalCommandLocalStorageHandler: ServiceResource.electrochemicalCommandLocalStorageHandler
            ),
          ),
        ],
        child: const HomeScreen(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
