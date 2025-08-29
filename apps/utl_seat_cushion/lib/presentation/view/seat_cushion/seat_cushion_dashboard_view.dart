import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_seat_cushion/presentation/view/seat_cushion/widgets/2d/seat_cushion_info_widget.dart';
import 'package:utl_seat_cushion/presentation/view/seat_cushion/widgets/2d/seat_cushion_special_point_widget.dart';

import '../../../domain/model/entity/seat_cushion_entity.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';
import '../../../service/data_stream/seat_cushion_sensor.dart';
import '../../change_notifier/seat_cushion_sensor_data.dart';
import '../../change_notifier/seat_cushion_sensor_data_manager.dart';
import '../bluetooth/bluetooth_command_line.dart';
import 'widgets/seat_cushion_buttons_board.dart';
import 'widgets/seat_cushion_force_color_bar.dart';
import 'widgets/2d/seat_cushion_matrix_widget.dart';

class SeatCushionDashboardView extends StatelessWidget {
  const SeatCushionDashboardView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider(
      create: (_) => SeatCushionSensorDataManagerChangeNotifier(
        seatCushionSensorDataStream: context.read<SeatCushionSensorDataStream>(),
      ),
      builder: (context, _) {
        final theme = Theme.of(context);
        final appLocalizations = AppLocalizations.of(context)!;
        return ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  width: mediaQuery.size.width * (SeatCushionParameters.deviceWidth / SeatCushionParameters.allWidth),
                  child: ChangeNotifierProvider(
                    create: (_) =>
                        SeatCushionSensorDataChangeNotifier(
                          type: SeatCushionType.left,
                          seatCushionUnitsManagerChangeNotifier: context.read<
                              SeatCushionSensorDataManagerChangeNotifier>(),
                        ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SeatCushionMatrixWidget(),
                            SeatCushionSpecialPointWidget(),
                          ],
                        ),
                        SeatCushionInfoWidget(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * (((SeatCushionParameters.basePosition(type: SeatCushionType.left).x - SeatCushionParameters.basePosition(type: SeatCushionType.right).x).abs() - SeatCushionParameters.deviceWidth).abs() / SeatCushionParameters.allWidth),
                  child: VerticalDivider(),
                ),
                SizedBox(
                  width: mediaQuery.size.width * (SeatCushionParameters.deviceWidth / SeatCushionParameters.allWidth),
                  child: ChangeNotifierProvider(
                    create: (_) =>
                        SeatCushionSensorDataChangeNotifier(
                          type: SeatCushionType.right,
                          seatCushionUnitsManagerChangeNotifier: context.read<
                              SeatCushionSensorDataManagerChangeNotifier>(),
                        ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SeatCushionMatrixWidget(),
                            SeatCushionSpecialPointWidget(),
                          ],
                        ),
                        SeatCushionInfoWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BluetoothCommandLine(),
            SeatCushionButtonsBoard(),
            SeatCushionForceColorBar(
              colorHeight: 10,
            ),
            Builder(
              builder: (context) {
                final ischiumWidth = context.select<SeatCushionSensorDataManagerChangeNotifier, double?>((n) => n.ischiumWidth);
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
