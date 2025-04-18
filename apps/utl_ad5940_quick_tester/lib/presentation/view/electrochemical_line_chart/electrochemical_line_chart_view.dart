import 'dart:math';

import 'package:line_chart_utils/sf_cartesian_chart/sf_cartesian_chart_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

class ElectrochemicalLineChartView extends Selector<ElectrochemicalLineChartChangeNotifier, List<LineSeries<Point<double>, double>>> {
  ElectrochemicalLineChartView({super.key}) : super(
    selector: (_, notifier) => notifier.createLineSeriesList(),
    builder: (context, series, _) {
      final notifier = context.read<ElectrochemicalLineChartChangeNotifier>();
      return SfCartesianChart(
        onTrackballPositionChanging: (TrackballArgs trackballArgs) {
          final source = SfCartesianChartHandler.findSourceOnTrackballPositionChanging(
            series: series,
            trackballArgs: trackballArgs,
          );
          if(source == null) return;
          notifier.x = source.x;
        },
        onChartTouchInteractionDown: (_) {
          notifier.isTouched = true;
        },
        onChartTouchInteractionUp: (_) {
          notifier.isTouched = false;
        },
        series: series,
        trackballBehavior: TrackballBehavior(
          enable: true,
          shouldAlwaysShow: true,
          activationMode: ActivationMode.singleTap,
          tooltipAlignment: ChartAlignment.near,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          tooltipSettings: InteractiveTooltip(
            enable: true,
          ),
          lineType: TrackballLineType.vertical,
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          // enableDoubleTapZooming: true,
          enablePanning: true,
          // zoomMode: ZoomMode.x,
          enableMouseWheelZooming: true,
        ),
      );
    }
  );
}
