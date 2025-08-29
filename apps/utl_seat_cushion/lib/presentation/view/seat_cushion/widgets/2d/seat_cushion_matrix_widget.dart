import 'package:flutter/material.dart';

import 'seat_cushion_unit_widget.dart';
import '../../../../../domain/model/entity/seat_cushion_entity.dart';

class SeatCushionMatrixWidget extends StatelessWidget {
  const SeatCushionMatrixWidget({
    super.key,
  });
  static const _unitAspectRatio = SeatCushionParameters.unitWidth / SeatCushionParameters.unitHeight;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            ...List.generate(SeatCushionParameters.unitsMaxRow, (rowIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(SeatCushionParameters.unitsMaxColumn, (colIndex) {
                  final width = constraints.maxWidth / SeatCushionParameters.unitsMaxColumn;
                  final height = width / _unitAspectRatio;
                  return SeatCushionUnitWidget(
                    rowIndex: rowIndex,
                    columnIndex: colIndex,
                    width: width,
                    height: height,
                  );
                }).toList(),
              );
            }),
          ],
        );
      },
    );
  }
}
