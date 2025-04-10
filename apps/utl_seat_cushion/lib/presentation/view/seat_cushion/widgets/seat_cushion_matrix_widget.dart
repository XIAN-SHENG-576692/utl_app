import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import './seat_cushion_unit_widget.dart';
import '../../../../domain/model/entity/seat_cushion_entity.dart';
import '../../../change_notifier/seat_cushion_units.dart';

class SeatCushionMatrixWidget extends StatelessWidget {
  const SeatCushionMatrixWidget({
    super.key,
  });
  static const unitAspectRatio = SeatCushionParameters.unitWidth / SeatCushionParameters.unitHeight;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final centerOfForces = context.select<SeatCushionUnitsChangeNotifier, Point<double>?>((n) => n.ischiumPosition);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        ...List.generate(SeatCushionParameters.unitsMaxRow, (rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(SeatCushionParameters.unitsMaxColumn, (colIndex) {
              final width = mediaQuery.size.width / SeatCushionParameters.unitsMaxColumn;
              final height = width / unitAspectRatio;
              return SeatCushionUnitWidget(
                rowIndex: rowIndex,
                columnIndex: colIndex,
                width: width,
                height: height,
              );
            }).toList(),
          );
        }),
        Text(
          "${appLocalizations.ischiumPosition}: "
              "(${centerOfForces?.x.toStringAsFixed(4).padLeft(8, " ")} mm,"
              " ${centerOfForces?.y.toStringAsFixed(4).padLeft(8, " ")} mm)",
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
