import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'line_chart_change_notifier.dart';

class LineSeriesListChartChangeNotifier<Source, X> extends LineChartChangeNotifier<X> {
  List<LineSeries<Source, X>> _lineSeriesList = [];
  List<LineSeries<Source, X>> get lineSeriesList => _lineSeriesList;
  LineSeriesListChartChangeNotifier({
    required super.x,
  });
  set lineSeriesList(List<LineSeries<Source, X>> seriesList) {
    _lineSeriesList = seriesList;
    notifyListeners();
  }
  @protected
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  @override
  void notifyListeners() => super.notifyListeners();
}
