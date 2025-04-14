import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../line_chart_change_notifier.dart';

/// A notifier class that extends [LineChartChangeNotifier] to manage
/// a list of line series for a chart visualization.
///
/// It provides reactive updates when the list of line series changes,
/// enabling chart components to respond and re-render accordingly.
///
/// Type Parameters:
/// - [Source]: The data source type for the line series.
/// - [X]: The type of data represented on the X-axis.
class LineSeriesListChartChangeNotifier<Source, X> extends LineChartChangeNotifier<X> {
  // Internal storage for the list of line series.
  List<LineSeries<Source, X>> _lineSeriesList = [];

  /// Getter for the current list of line series.
  List<LineSeries<Source, X>> get lineSeriesList => _lineSeriesList;

  /// Constructor that requires the initial X-axis value.
  /// Passes the value to the superclass [LineChartChangeNotifier].
  LineSeriesListChartChangeNotifier({
    required super.x,
  });

  /// Setter for the line series list.
  /// When updated, it notifies listeners so that dependent widgets
  /// (e.g., charts) can refresh based on the new data.
  set lineSeriesList(List<LineSeries<Source, X>> seriesList) {
    _lineSeriesList = seriesList;
    notifyListeners();
  }

  /// Notifies all registered listeners of changes.
  /// This override includes metadata for testing and debugging support.
  @protected
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  @override
  void notifyListeners() => super.notifyListeners();
}
