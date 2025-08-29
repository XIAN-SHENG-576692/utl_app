import 'package:common_utils/dataset_color_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/model/entity/seat_cushion_entity.dart';
import '../../../../change_notifier/seat_cushion_sensor_data.dart';
import '../../../../theme/theme_data.dart';

class SeatCushionUnitWidget extends StatelessWidget {
  static double borderWidth = 1.0;
  static double borderRadius = 1.0;
  final int rowIndex;
  final int columnIndex;
  final double width;
  final double height;
  const SeatCushionUnitWidget({
    super.key,
    required this.rowIndex,
    required this.columnIndex,
    required this.width,
    required this.height,
  });
  static forceColor({
    required int force,
  }) {
    int index = SeatCushionParameters.forceMax - force;
    int length = SeatCushionParameters.forceMax - SeatCushionParameters.forceMin;
    return DatasetColorGenerator.rainbow(
      alpha: 1.0,
      index: index,
      length: length,
      hueMax: 255.0,
      hueMin: -45.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    final force = context.select<SeatCushionSensorDataChangeNotifier, int>((units) => units.units
      ?.where((e) => e.row == rowIndex && e.column == columnIndex)
      .firstOrNull
      ?.force
      ?? 0
    );
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: forceColor(force: force),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: themeData.seatCushionUnitBorderColor,
          width: borderWidth,
        ),
      ),
      width: width,
      height: height,
    );
  }
}
