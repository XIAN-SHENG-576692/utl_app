import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../../change_notifier/seat_cushion_sensor_data.dart';

class SeatCushionInfoWidget extends StatelessWidget {
  const SeatCushionInfoWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ischiumPosition = context.select<SeatCushionSensorDataChangeNotifier, Point<double>?>((n) => n.ischiumPosition);
    final appLocalizations = AppLocalizations.of(context)!;
    return Text(
      "${appLocalizations.ischiumPosition}: "
        "(${ischiumPosition?.x.toStringAsFixed(4).padLeft(8, " ")} mm,"
        " ${ischiumPosition?.y.toStringAsFixed(4).padLeft(8, " ")} mm)",
      style: theme.textTheme.bodyLarge,
    );
  }
}
