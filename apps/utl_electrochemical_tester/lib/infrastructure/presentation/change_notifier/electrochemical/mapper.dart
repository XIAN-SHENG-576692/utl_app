part of 'electrochemical_line_chart_change_notifier.dart';

class _Mapper {
  const _Mapper._();
  static int? mapLineChartXToRealX({
    required double lineChartX,
    required ElectrochemicalLineChartMode mode,
  }) {
    switch(mode) {
      case ElectrochemicalLineChartMode.ampereIndex:
        return lineChartX.toInt();
      case ElectrochemicalLineChartMode.ampereTime:
        return (lineChartX * 1e3).toInt();
      case ElectrochemicalLineChartMode.ampereVolt:
        return (lineChartX * 1e3).toInt();
    }
  }
  static Color mapElectrochemicalEntityToColor({
    required ElectrochemicalEntity entity,
    required int index,
    required int length,
  }) {
    return DatasetColorGenerator.rainbowGroup(
      alpha: 1.0,
      index: index + 10,
      length: length + 10,
      groupIndex: ElectrochemicalType.values.indexWhere((type) => type == entity.electrochemicalHeader.type),
      groupLength: ElectrochemicalType.values.length,
    );
  }
  static List<LineSeries<Point<double>, double>> mapElectrochemicalEntitiesToLineChartSeriesList({
    required Iterable<ElectrochemicalEntity> entities,
    required ElectrochemicalLineChartMode mode,
  }) {
    return entities
      .indexed.map((element) {
        int length = entities.length;
        int index = element.$1;
        var entity = element.$2;
        return LineSeries<Point<double>, double>(
          name: entity.electrochemicalHeader.dataName,
          dataSource: entity.data.map((e) {
            switch(mode) {
              case ElectrochemicalLineChartMode.ampereIndex:
                return Point<double>(
                  e.index.toDouble(),
                  e.current / 1e3,
                );
              case ElectrochemicalLineChartMode.ampereTime:
                return Point<double>(
                  e.time / 1e3,
                  e.current / 1e3,
                );
              case ElectrochemicalLineChartMode.ampereVolt:
                return Point<double>(
                  e.voltage / 1e3,
                  e.current / 1e3,
                );
            }
          }).toList(),
          animationDuration: 0,
          xValueMapper: (Point<double> data, _) => data.x,
          yValueMapper: (Point<double> data, _) => data.y,
          color: mapElectrochemicalEntityToColor(
            entity: entity,
            index: index,
            length: length,
          ),
          width: 1.5,
          // markerSettings: MarkerSettings(isVisible: true),
        );
      }).toList();
  }
  static List<ElectrochemicalLineChartDetail> mapElectrochemicalEntitiesToLineChartDetails({
    required Iterable<ElectrochemicalEntity> entities,
    required int? x,
    required ElectrochemicalLineChartMode mode,
  }) {
    return entities
      .indexed.map((element) {
        int length = entities.length;
        int index = element.$1;
        var entity = element.$2;
        final data = (x == null)
          ? List<ElectrochemicalLineChartDetailData>.empty()
          : entity.data.where((d) {
            switch(mode) {
              case ElectrochemicalLineChartMode.ampereIndex:
                return d.index == x;
              case ElectrochemicalLineChartMode.ampereTime:
                return d.time == x;
              case ElectrochemicalLineChartMode.ampereVolt:
                return d.voltage == x;
            }
          }).map((d) {
            return ElectrochemicalLineChartDetailData(
              index: d.index,
              time: d.time / 1e3,
              voltage: d.voltage / 1e3,
              current: d.current / 1e3,
            );
          }).toList();
        return ElectrochemicalLineChartDetail(
          color: mapElectrochemicalEntityToColor(
            entity: entity,
            index: index,
            length: length,
          ),
          createdTime: entity.electrochemicalHeader.createdTime,
          data: data,
          dataName: entity.electrochemicalHeader.dataName,
          deviceId: entity.electrochemicalHeader.deviceId,
          temperature: entity.electrochemicalHeader.temperature / 1e6,
          type: entity.electrochemicalHeader.type,
        );
      }).toList();
  }
}
