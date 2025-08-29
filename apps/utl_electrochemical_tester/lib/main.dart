import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:utl_electrochemical_tester/init/initializer.dart';
import 'package:utl_electrochemical_tester/init/resource/infrastructure/path_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/data/repository_resource.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/command/electrochemical_command_change_notifier.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/feature/electrochemical_feature_change_notifier.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/repository/electrochemical_repository_sync_change_notifier.dart';
import 'package:utl_electrochemical_tester/presentation/screen/home_screen.dart';

import 'init/resource/service/service_resource.dart';
import 'l10n/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  for(final permission in [
    Permission.location,
    Permission.bluetooth,
  ]) {
    if(!(await permission.request()).isGranted) {
      return SystemNavigator.pop();
    }
  }
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
          ChangeNotifierProvider<ElectrochemicalRepositorySyncChangeNotifier>(
            create: (_) => ElectrochemicalRepositorySyncChangeNotifier(
                initFetch: true,
                electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
            ),
          ),
          ChangeNotifierProvider<ElectrochemicalFeatureChangeNotifier>(
            create: (_) => ElectrochemicalFeatureChangeNotifier(
              electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
              fileHandler: ServiceResource.fileHandler,
              folderPath: PathResource.downloadPath,
            ),
          ),
          ChangeNotifierProvider<ElectrochemicalCommandChangeNotifier>(
            create: (_) => ElectrochemicalCommandChangeNotifier(
              electrochemicalDevicesManager: ServiceResource.electrochemicalDevicesManager,
              electrochemicalCommandLocalStorageHandler: ServiceResource.electrochemicalCommandLocalStorageHandler,
            ),
          ),
        ],
        builder: (context, _) {
          return ChangeNotifierProxyProvider<ElectrochemicalRepositorySyncChangeNotifier, ElectrochemicalLineChartChangeNotifier>(
            create: (context) => ElectrochemicalLineChartChangeNotifier(
              mode: ElectrochemicalLineChartMode.ca,
            ),
            update: (_, s, prev) {
              if(prev != null) return prev..updateEntities(s.entities);
              return ElectrochemicalLineChartChangeNotifier(mode: prev?.mode ?? ElectrochemicalLineChartMode.ca, entities: s.entities);
            },
            builder: (context, _) => const HomeScreen(),
          );
        }
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
