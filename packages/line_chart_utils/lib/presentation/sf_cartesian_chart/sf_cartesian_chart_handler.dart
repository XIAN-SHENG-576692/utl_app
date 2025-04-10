import 'package:syncfusion_flutter_charts/charts.dart';

class SfCartesianChartHandler {
  SfCartesianChartHandler._();
  static Source? findSourceOnTrackballPositionChanging<Source, X>({
    required List<LineSeries<Source, X>> series,
    required TrackballArgs trackballArgs,
  }) {
    int? seriesIndex = trackballArgs.chartPointInfo.seriesIndex;
    int? dataPointIndex = trackballArgs.chartPointInfo.dataPointIndex;
    if (seriesIndex == null || dataPointIndex == null) return null;
    return series
      .elementAtOrNull(trackballArgs.chartPointInfo.seriesIndex!)
      ?.dataSource
      ?.elementAtOrNull(trackballArgs.chartPointInfo.dataPointIndex!);
  }
}
