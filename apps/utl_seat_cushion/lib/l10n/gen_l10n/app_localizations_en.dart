// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'UTL Seat Cushion App';

  @override
  String get connectBluetoothButtonText => 'Connect';

  @override
  String get disconnectBluetoothButtonText => 'Disconnect';

  @override
  String get sendSeatCushionCommandButtonText => 'Send Command';

  @override
  String get startSavingSeatCushionEntityButtonText => 'Start Saving Data';

  @override
  String get endSavingSeatCushionEntityButtonText => 'End Saving Data';

  @override
  String get clearOldDataButtonText => 'Clear Old Data';

  @override
  String get clearOldDataNotification => 'Clear old data finished.';

  @override
  String downloadFileButtonText(String format) {
    return 'Download $format file';
  }

  @override
  String downloadFileFinishedNotification(Object format) {
    return 'Download $format file finished.';
  }

  @override
  String get name => 'Name';

  @override
  String get time => 'Time';

  @override
  String get device => 'Device';

  @override
  String get deviceId => 'Device ID';

  @override
  String get type => 'Type';

  @override
  String get index => 'Index';

  @override
  String get number => 'Number';

  @override
  String get seatCushion => 'Seat Cushion';

  @override
  String get force => 'Force';

  @override
  String get centerOfForces => 'Center Of Forces';

  @override
  String get ischiumPosition => 'Ischium Position';

  @override
  String get ischiumWidth => 'Ischium Width';
}
