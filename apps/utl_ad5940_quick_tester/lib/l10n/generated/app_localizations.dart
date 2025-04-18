import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'TW')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'UTL Electrochemical Tester App'**
  String get appName;

  /// No description provided for @downloadFileFinishedNotification.
  ///
  /// In en, this message translates to:
  /// **'Download {format} file finished.'**
  String downloadFileFinishedNotification(Object format);

  /// No description provided for @clearAllDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all data'**
  String get clearAllDataTitle;

  /// No description provided for @areYouSureYouWantToClearAllDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all data?'**
  String get areYouSureYouWantToClearAllDataMessage;

  /// No description provided for @yesButtonText.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesButtonText;

  /// No description provided for @noButtonText.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noButtonText;

  /// No description provided for @connectBluetoothButtonText.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connectBluetoothButtonText;

  /// No description provided for @disconnectBluetoothButtonText.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnectBluetoothButtonText;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String get name;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'time'**
  String get time;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'device'**
  String get device;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'type'**
  String get type;

  /// No description provided for @index.
  ///
  /// In en, this message translates to:
  /// **'index'**
  String get index;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'number'**
  String get number;

  /// No description provided for @cortisol.
  ///
  /// In en, this message translates to:
  /// **'cortisol'**
  String get cortisol;

  /// No description provided for @lactate.
  ///
  /// In en, this message translates to:
  /// **'lactate'**
  String get lactate;

  /// No description provided for @h1n1.
  ///
  /// In en, this message translates to:
  /// **'H1N1'**
  String get h1n1;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'temperature'**
  String get temperature;

  /// No description provided for @voltage.
  ///
  /// In en, this message translates to:
  /// **'voltage'**
  String get voltage;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'current'**
  String get current;

  /// No description provided for @ca.
  ///
  /// In en, this message translates to:
  /// **'CA'**
  String get ca;

  /// No description provided for @cv.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get cv;

  /// No description provided for @dpv.
  ///
  /// In en, this message translates to:
  /// **'DPV'**
  String get dpv;

  /// No description provided for @eDc.
  ///
  /// In en, this message translates to:
  /// **'E_dc'**
  String get eDc;

  /// No description provided for @tInterval.
  ///
  /// In en, this message translates to:
  /// **'t_interval'**
  String get tInterval;

  /// No description provided for @tRun.
  ///
  /// In en, this message translates to:
  /// **'t_run'**
  String get tRun;

  /// No description provided for @eVertex1.
  ///
  /// In en, this message translates to:
  /// **'E_vertex1'**
  String get eVertex1;

  /// No description provided for @eVertex2.
  ///
  /// In en, this message translates to:
  /// **'E_vertex2'**
  String get eVertex2;

  /// No description provided for @numberOfScans.
  ///
  /// In en, this message translates to:
  /// **'number of scans'**
  String get numberOfScans;

  /// No description provided for @eBegin.
  ///
  /// In en, this message translates to:
  /// **'E_begin'**
  String get eBegin;

  /// No description provided for @eEnd.
  ///
  /// In en, this message translates to:
  /// **'E_end'**
  String get eEnd;

  /// No description provided for @eStep.
  ///
  /// In en, this message translates to:
  /// **'E_step'**
  String get eStep;

  /// No description provided for @ePulse.
  ///
  /// In en, this message translates to:
  /// **'E_pulse'**
  String get ePulse;

  /// No description provided for @tPulse.
  ///
  /// In en, this message translates to:
  /// **'t_pulse'**
  String get tPulse;

  /// No description provided for @scanRate.
  ///
  /// In en, this message translates to:
  /// **'scan rate'**
  String get scanRate;

  /// No description provided for @inversionOption.
  ///
  /// In en, this message translates to:
  /// **'inversion option'**
  String get inversionOption;

  /// No description provided for @ad5940ParametersElectrochemicalWorkingElectrode.
  ///
  /// In en, this message translates to:
  /// **'AD5940 Working Electrode'**
  String get ad5940ParametersElectrochemicalWorkingElectrode;

  /// No description provided for @ad5940HsRTia.
  ///
  /// In en, this message translates to:
  /// **'AD5940 HsRTia'**
  String get ad5940HsRTia;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.countryCode) {
    case 'TW': return AppLocalizationsZhTw();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
