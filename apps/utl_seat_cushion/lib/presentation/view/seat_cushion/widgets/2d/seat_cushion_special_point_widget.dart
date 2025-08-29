import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';

import '../../../../change_notifier/seat_cushion_sensor_data.dart';
import '../../../../theme/theme_data.dart';

class _IschiumPoint extends CustomPainter {
  final double x;
  final double y;
  final BuildContext context;
  _IschiumPoint(this.context, this.x, this.y);
  @override
  void paint(Canvas canvas, Size size) {
    final theme = Theme.of(context);
    final point = Offset(x, y);
    final innerPaint = Paint()
      ..color = theme.ischiumPointFilledColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
    final outerPaint = Paint()
      ..color = theme.ischiumPointBorderColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0;
    canvas.drawPoints(PointMode.points, [point], outerPaint);
    canvas.drawPoints(PointMode.points, [point], innerPaint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SeatCushionSpecialPointWidget extends StatelessWidget {
  const SeatCushionSpecialPointWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ischiumPosition = context.select<SeatCushionSensorDataChangeNotifier, Point<double>?>((n) => n.ischiumPosition);
        final width = constraints.maxWidth;
        final height = width / SeatCushionParameters.deviceWidth * SeatCushionParameters.deviceHeight;
        return SizedBox(
          width: width,
          height: height,
          child: (ischiumPosition != null)
            ? CustomPaint(
              painter: _IschiumPoint(
                context,
                ((ischiumPosition.x/ SeatCushionParameters.deviceWidth) + 0.5) * width,
                ((ischiumPosition.y/ SeatCushionParameters.deviceHeight) + 0.5) * height,
              ),
              child: Container(),
            )
            : null,
        );
      },
    );
  }
}
