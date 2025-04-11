import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/entity/seat_cushion_entity.dart';
import '../../../service/data_stream/seat_cushion_sensor.dart';
import '../../change_notifier/seat_cushion_units.dart';
import '../../change_notifier/seat_cushion_units_manager.dart';
import '../bluetooth/bluetooth_command_line.dart';
import 'widgets/seat_cushion_buttons_board.dart';
import 'widgets/seat_cushion_force_color_bar.dart';
import 'widgets/seat_cushion_matrix_widget.dart';

class SeatCushionDashboardView extends StatelessWidget {
  const SeatCushionDashboardView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SeatCushionUnitsManagerChangeNotifier(
        seatCushionSensorDataStream: context.read<SeatCushionSensorDataStream>(),
      ),
      builder: (context, _) {
        final theme = Theme.of(context);
        final appLocalizations = AppLocalizations.of(context)!;
        return ListView(
          children: [
            ChangeNotifierProvider(
              create: (_) =>
                  SeatCushionUnitsChangeNotifier(
                    type: SeatCushionType.upper,
                    seatCushionUnitsManagerChangeNotifier: context.read<
                        SeatCushionUnitsManagerChangeNotifier>(),
                  ),
              child: SeatCushionMatrixWidget(),
            ),
            Divider(),
            ChangeNotifierProvider(
              create: (_) =>
                  SeatCushionUnitsChangeNotifier(
                    type: SeatCushionType.lower,
                    seatCushionUnitsManagerChangeNotifier: context.read<
                        SeatCushionUnitsManagerChangeNotifier>(),
                  ),
              child: SeatCushionMatrixWidget(),
            ),
            Divider(),
            BluetoothCommandLine(),
            SeatCushionButtonsBoard(),
            SeatCushionForceColorBar(
              colorHeight: 10,
            ),
            Builder(
              builder: (context) {
                final ischiumWidth = context.select<SeatCushionUnitsManagerChangeNotifier, double?>((n) => n.ischiumWidth);
                return Text(
                  "${appLocalizations.ischiumWidth}: ${ischiumWidth?.toStringAsFixed(4).padLeft(8, " ")} mm",
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                );
              }
            ),
          ],
        );
      }
    );
  }
}
