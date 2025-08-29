// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'UTL 电化学测试 App';

  @override
  String downloadFileFinishedNotification(Object format) {
    return '下载 $format 完成。';
  }

  @override
  String get yesButtonText => '确定';

  @override
  String get noButtonText => '取消';

  @override
  String get downloadButtonText => '下载';

  @override
  String get cancelButtonText => '取消';

  @override
  String get connectBluetoothButtonText => '连接';

  @override
  String get disconnectBluetoothButtonText => '断开连接';

  @override
  String get name => '名字';

  @override
  String get time => '时间';

  @override
  String get device => '设备';

  @override
  String get type => '类别';

  @override
  String get index => '索引';

  @override
  String get number => '数量';

  @override
  String get cortisol => '皮质醇';

  @override
  String get lactate => '乳酸';

  @override
  String get h1n1 => 'H1N1';

  @override
  String get temperature => '温度';

  @override
  String get voltage => '电压';

  @override
  String get current => '电流';

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
  String get ad5940ParameterElectrodes => 'AD5940 Electrodes';

  @override
  String get ad5940HsRTia => 'AD5940 HsRTia';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw(): super('zh_TW');

  @override
  String get appName => 'UTL 電化學測試 App';

  @override
  String downloadFileFinishedNotification(Object format) {
    return '下載 $format 完成。';
  }

  @override
  String get yesButtonText => '確定';

  @override
  String get noButtonText => '取消';

  @override
  String get downloadButtonText => '下載';

  @override
  String get cancelButtonText => '取消';

  @override
  String get connectBluetoothButtonText => '連接';

  @override
  String get disconnectBluetoothButtonText => '斷開連接';

  @override
  String get name => '名字';

  @override
  String get time => '時間';

  @override
  String get device => '設備';

  @override
  String get type => '類別';

  @override
  String get index => '索引';

  @override
  String get number => '數量';

  @override
  String get cortisol => '皮質醇';

  @override
  String get lactate => '乳酸';

  @override
  String get h1n1 => 'H1N1';

  @override
  String get temperature => '溫度';

  @override
  String get voltage => '電壓';

  @override
  String get current => '電流';
}
