import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:utl_electrochemical_tester/presentation/mapper/colors_mapper.dart';

import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
import '../../../mapper/line_chart_mapper.dart';
import 'electrochemical_line_chart_details_tile.dart';

class _TitleStatus extends Equatable {
  ElectrochemicalLineChartMode mode;
  double? x;
  _TitleStatus({required this.mode, required this.x});
  @override
  List<Object?> get props => [
    mode,
    x,
  ];
}

class _Title extends Selector<ElectrochemicalLineChartChangeNotifier, _TitleStatus> {
  _Title({super.key}) : super(
    selector: (_, notifier) => _TitleStatus(mode: notifier.mode, x: notifier.x),
    builder: (context, status, _) {
      final mode = status.mode;
      final x = status.x;
      String xInfo;
      final appLocalizations = AppLocalizations.of(context)!;
      switch (mode) {
        case ElectrochemicalLineChartMode.ca: {
          String label = appLocalizations.index;
          xInfo = "$label: ${x?.toInt() ?? ""}";
          break;
        }
        case ElectrochemicalLineChartMode.cv:
        case ElectrochemicalLineChartMode.dpv: {
          String label = appLocalizations.voltage;
          String unit = "V";
          xInfo = "$label: ${"$x ($unit)" ?? ""}";
          break;
        }
        case ElectrochemicalLineChartMode.eis0:
          // TODO: Handle this case.
          xInfo = "";
          break;
        case ElectrochemicalLineChartMode.eis1:
          // TODO: Handle this case.
          xInfo = "";
          break;
      }
      return Text(
        xInfo,
        softWrap: true,
      );
    },
  );
}

class ElectrochemicalLineChartDetailsView extends StatelessWidget {
  const ElectrochemicalLineChartDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final mode = context.select<ElectrochemicalLineChartChangeNotifier, ElectrochemicalLineChartMode>((notifier) => notifier.mode);
    final x = context.select<ElectrochemicalLineChartChangeNotifier, double?>((notifier) => notifier.x);
    final dtoList = context.select<ElectrochemicalLineChartChangeNotifier, List<ElectrochemicalLineChartDetailsTileDto>>((notifier) {
      final entities = notifier.entities.toList(growable: false);
      return entities.indexed.map((e) {
        final index = e.$1;
        final entity = e.$2;
        return ElectrochemicalLineChartDetailsTileDto(
          color: ColorsMapper.mapElectrochemicalEntitiesToColor(index: index, length: entities.length),
          header: entity.header,
          xFetchedData: LineChartMapper
              .getPoints(mode: mode, entity: entity)
              .where((p) => p.x == x).map((p) => p.y)
              .toList(growable: false),
        );
      }).toList(growable: false);
    });
    return Column(
      children: [
        _Title(),
        Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: dtoList.length,
            itemBuilder: (context, index) {
              var dto = dtoList[index];
              return Selector<ElectrochemicalLineChartChangeNotifier, ElectrochemicalLineChartMode>(
                selector: (_, notifier) => notifier.mode,
                builder: (context, mode, _) {
                  return ElectrochemicalLineChartDetailsTile(dto: dto, mode: mode);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
