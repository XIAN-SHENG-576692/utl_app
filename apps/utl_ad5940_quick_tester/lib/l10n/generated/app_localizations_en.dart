// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'UTL Electrochemical Tester App';

  @override
  String downloadFileFinishedNotification(Object format) {
    return 'Download $format file finished.';
  }

  @override
  String get clearAllDataTitle => 'Clear all data';

  @override
  String get areYouSureYouWantToClearAllDataMessage => 'Are you sure you want to clear all data?';

  @override
  String get yesButtonText => 'Yes';

  @override
  String get noButtonText => 'No';

  @override
  String get connectBluetoothButtonText => 'Connect';

  @override
  String get disconnectBluetoothButtonText => 'Disconnect';

  @override
  String get name => 'name';

  @override
  String get time => 'time';

  @override
  String get device => 'device';

  @override
  String get type => 'type';

  @override
  String get index => 'index';

  @override
  String get number => 'number';

  @override
  String get cortisol => 'cortisol';

  @override
  String get lactate => 'lactate';

  @override
  String get h1n1 => 'H1N1';

  @override
  String get temperature => 'temperature';

  @override
  String get voltage => 'voltage';

  @override
  String get current => 'current';

  @override
  String get ca => 'CA';

  @override
  String get cv => 'CV';

  @override
  String get dpv => 'DPV';

  @override
  String get eDc => 'E_dc';

  @override
  String get tInterval => 't_interval';

  @override
  String get tRun => 't_run';

  @override
  String get eVertex1 => 'E_vertex1';

  @override
  String get eVertex2 => 'E_vertex2';

  @override
  String get numberOfScans => 'number of scans';

  @override
  String get eBegin => 'E_begin';

  @override
  String get eEnd => 'E_end';

  @override
  String get eStep => 'E_step';

  @override
  String get ePulse => 'E_pulse';

  @override
  String get tPulse => 't_pulse';

  @override
  String get scanRate => 'scan rate';

  @override
  String get inversionOption => 'inversion option';

  @override
  String get ad5940ParametersElectrochemicalWorkingElectrode => 'AD5940 Working Electrode';

  @override
  String get ad5940HsRTia => 'AD5940 HsRTia';
}
