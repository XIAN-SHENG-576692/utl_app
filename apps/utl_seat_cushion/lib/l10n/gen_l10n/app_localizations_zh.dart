// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'UTL Seat Cushion App';

  @override
  String get connectBluetoothButtonText => '连接';

  @override
  String get disconnectBluetoothButtonText => '断开连接';

  @override
  String get sendSeatCushionCommandButtonText => '发送指令';

  @override
  String get startSavingSeatCushionEntityButtonText => '开始保存数据';

  @override
  String get endSavingSeatCushionEntityButtonText => '结束保存数据';

  @override
  String get clearOldDataButtonText => '删除旧数据';

  @override
  String get clearOldDataNotification => '删除旧数据完成。';

  @override
  String downloadFileButtonText(String format) {
    return '下载 $format 文件';
  }

  @override
  String downloadFileFinishedNotification(Object format) {
    return '下载 $format 完成。';
  }

  @override
  String get name => '名字';

  @override
  String get time => '时间';

  @override
  String get device => '设备';

  @override
  String get deviceId => '设备 ID';

  @override
  String get type => '类别';

  @override
  String get index => '索引';

  @override
  String get number => '数量';

  @override
  String get seatCushion => '坐垫';

  @override
  String get force => '力量';

  @override
  String get centerOfForces => '力量中心';

  @override
  String get ischiumPosition => '坐骨位置';

  @override
  String get ischiumWidth => '坐骨宽度';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw(): super('zh_TW');

  @override
  String get appName => 'UTL Seat Cushion App';

  @override
  String get connectBluetoothButtonText => '連接';

  @override
  String get disconnectBluetoothButtonText => '斷開連接';

  @override
  String get sendSeatCushionCommandButtonText => '發送指令';

  @override
  String get startSavingSeatCushionEntityButtonText => '開始保存數據';

  @override
  String get endSavingSeatCushionEntityButtonText => '結束保存數據';

  @override
  String get clearOldDataButtonText => '刪除舊數據';

  @override
  String get clearOldDataNotification => '刪除舊數據完成。';

  @override
  String downloadFileButtonText(String format) {
    return '下載 $format 文件';
  }

  @override
  String downloadFileFinishedNotification(Object format) {
    return '下載 $format 完成。';
  }

  @override
  String get name => '名字';

  @override
  String get time => '時間';

  @override
  String get device => '設備';

  @override
  String get deviceId => '設備 ID';

  @override
  String get type => '類別';

  @override
  String get index => '索引';

  @override
  String get number => '數量';

  @override
  String get seatCushion => '坐墊';

  @override
  String get force => '力量';

  @override
  String get centerOfForces => '力量中心';

  @override
  String get ischiumPosition => '坐骨位置';

  @override
  String get ischiumWidth => '坐骨寬度';
}
