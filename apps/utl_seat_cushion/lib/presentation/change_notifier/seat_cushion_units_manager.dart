import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';

import '../../service/data_stream/seat_cushion_sensor.dart';

class SeatCushionUnitsManagerChangeNotifier extends ChangeNotifier {
  @protected
  final SeatCushionSensorDataStream seatCushionSensorDataStream;
  late final StreamSubscription _subscription;
  final List<SeatCushionSensorData> dataList = [];
  double? get ischiumWidth {
    final upper = dataList.where((e) => e.type == SeatCushionType.upper).firstOrNull;
    if(upper == null) return null;
    final lower = dataList.where((e) => e.type == SeatCushionType.lower).firstOrNull;
    if(lower == null) return null;
    return SeatCushionCalculator.ischiumWidth(upper: upper, lower: lower);
  }
  SeatCushionUnitsManagerChangeNotifier({
    required this.seatCushionSensorDataStream,
  }) {
    _subscription = seatCushionSensorDataStream.seatCushionSensorDataStream.listen((data) {
      dataList.removeWhere((e) => e.type == data.type);
      dataList.add(data);
      notifyListeners();
    });
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
