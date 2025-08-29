import 'package:equatable/equatable.dart';
import 'package:line_chart_utils/sf_cartesian_chart/sf_cartesian_chart_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

import '../../mapper/line_chart_mapper.dart';

class _Dto extends Equatable {
  final ElectrochemicalEntity entity;
  const _Dto(this.entity);
  @override
  List<Object?> get props => [
    entity.id,
    entity.header,
    ...entity.data,
  ];
}

class _DtoList extends Equatable {
  final ElectrochemicalLineChartMode mode;
  final List<_Dto> dto;
  const _DtoList(this.mode, this.dto);
  @override
  List<Object?> get props => [
    mode,
    dto,
  ];
}

class ElectrochemicalLineChart extends Selector<ElectrochemicalLineChartChangeNotifier, _DtoList> {
  ElectrochemicalLineChart({super.key}) : super(
    selector: (_, notifier) => _DtoList(notifier.mode, notifier.entities.map((e) => _Dto(e)).toList(growable: false)),
    builder: (context, dtoList, _) {
      final series = LineChartMapper.mapElectrochemicalEntitiesToLineChartSeriesList(
          entities: dtoList.dto.map((d) => d.entity),
          mode: dtoList.mode,
      );
      final notifier = context.read<ElectrochemicalLineChartChangeNotifier>();
      return SfCartesianChart(
        onTrackballPositionChanging: (TrackballArgs trackballArgs) {
          final source = SfCartesianChartHandler.findSourceOnTrackballPositionChanging(
            series: series,
            trackballArgs: trackballArgs,
          );
          if(source == null) return;
          notifier.updateX(source.x);
        },
        onChartTouchInteractionDown: (_) {
          notifier.updateIsTouched(true);
        },
        onChartTouchInteractionUp: (_) {
          notifier.updateIsTouched(false);
        },
        series: series,
        trackballBehavior: TrackballBehavior(
          enable: true,
          shouldAlwaysShow: true,
          activationMode: ActivationMode.singleTap,
          tooltipAlignment: ChartAlignment.near,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          // tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
          // tooltipSettings: InteractiveTooltip(
          //   enable: true,
          // ),
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
