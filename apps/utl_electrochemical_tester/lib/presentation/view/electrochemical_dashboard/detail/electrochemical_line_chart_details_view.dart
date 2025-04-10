import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';
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
        case ElectrochemicalLineChartMode.ampereIndex: {
          String label = appLocalizations.index;
          xInfo = "$label: ${x?.toInt() ?? ""}";
          break;
        }
        case ElectrochemicalLineChartMode.ampereTime: {
          String label = appLocalizations.time;
          String unit = "s";
          xInfo = "$label: ${"$x ($unit)" ?? ""}";
          break;
        }
        case ElectrochemicalLineChartMode.ampereVolt: {
          String label = appLocalizations.voltage;
          String unit = "V";
          xInfo = "$label: ${"$x ($unit)" ?? ""}";
          break;
        }
      }
      return Text(
        xInfo,
        softWrap: true,
      );
    },
  );
}

class ElectrochemicalLineChartDetailsView extends Selector<ElectrochemicalLineChartChangeNotifier, List<ElectrochemicalLineChartDetail>> {
  ElectrochemicalLineChartDetailsView({super.key}) : super(
    selector: (_, notifier) => notifier.details,
    builder: (context, details, _) {
      return Column(
        children: [
          _Title(),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, index) {
                var detail = details[index];
                return Selector<ElectrochemicalLineChartChangeNotifier, ElectrochemicalLineChartMode>(
                  selector: (_, notifier) => notifier.mode,
                  builder: (context, mode, _) {
                    return ElectrochemicalLineChartDetailsTile(detail: detail, mode: mode);
                  },
                );
              },
            ),
          ),
        ],
      );
    }
  );
}
