part of 'electrochemical_line_chart_change_notifier.dart';

class ElectrochemicalLineChartDetailData extends Equatable {
  int index;
  double time;
  double voltage;
  double current;
  ElectrochemicalLineChartDetailData({
    required this.index,
    required this.time,
    required this.voltage,
    required this.current,
  });

  @override
  String toString() {
    return "ElectrochemicalUiDtoData: index: $index, time: $time, voltage: $voltage, current: $current";
  }

  @override
  List<Object?> get props => [
    index,
    time,
    voltage,
    current,
  ];
}

class ElectrochemicalLineChartDetail extends Equatable {
  final String dataName;
  final String deviceId;
  final DateTime createdTime;
  final ElectrochemicalType type;
  final double temperature;
  final Color color;

  final List<ElectrochemicalLineChartDetailData> data;

  const ElectrochemicalLineChartDetail({
    required this.color,
    required this.createdTime,
    required this.data,
    required this.dataName,
    required this.deviceId,
    required this.temperature,
    required this.type,
  });

  @override
  List<Object?> get props => [
    dataName,
    deviceId,
    createdTime,
    type,
    temperature,
    color,
    data,
  ];
}
