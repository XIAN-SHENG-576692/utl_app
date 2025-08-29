import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex_keyboard/hex_keyboard_manager.dart';
import 'package:provider/provider.dart';
import 'package:utl_seat_cushion/presentation/theme/theme_data.dart';

import 'init/application_persist.dart';
import 'init/initializer.dart';
import 'init/resource/bluetooth_resource.dart';
import 'init/resource/data_resource.dart';
import 'init/resource/service_resource.dart';
import 'l10n/gen_l10n/app_localizations.dart';
import 'presentation/change_notifier/seat_cushion_features.dart';
import 'presentation/screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final initializer = Initializer();
  await initializer();
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    // var appLocalizations = AppLocalizations.of(context)!;
    var themeData = Theme.of(context);
    return MaterialApp(
      // title: appLocalizations.appName,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      color: themeData.screenBackgroundColor,
      home: MultiProvider(
        providers: [
          Provider(create: (_) => BluetoothResource.bluetoothModule),
          Provider(create: (_) => DataResource.seatCushionRepository),
          Provider(create: (_) => ServiceResource.fileHandler),
          Provider(create: (_) => ServiceResource.seatCushionSensorDataStream),
          Provider(create: (_) => ApplicationPersist.seatCushionSensorDataHandler),
          ChangeNotifierProvider(create: (_) => HexKeyboardManager()),
          ChangeNotifierProvider(create: (_) => SeatCushionFeaturesChangeNotifier(
            fileHandler: ServiceResource.fileHandler,
            seatCushionSensorDataHandler: ApplicationPersist.seatCushionSensorDataHandler,
            seatCushionRepository: DataResource.seatCushionRepository,
          )),
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
