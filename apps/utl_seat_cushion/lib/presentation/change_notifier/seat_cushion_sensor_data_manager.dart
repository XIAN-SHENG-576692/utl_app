import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';

import '../../service/data_stream/seat_cushion_sensor.dart';

class SeatCushionSensorDataManagerChangeNotifier extends ChangeNotifier {
  @protected
  final SeatCushionSensorDataStream seatCushionSensorDataStream;
  late final StreamSubscription _subscription;
  final List<SeatCushionSensorData> dataList = [];
  double? get ischiumWidth {
    final upper = dataList.where((e) => e.type == SeatCushionType.right).firstOrNull;
    if(upper == null) return null;
    final lower = dataList.where((e) => e.type == SeatCushionType.left).firstOrNull;
    if(lower == null) return null;
    return SeatCushionCalculator.ischiumWidth(left: upper, right: lower);
  }
  SeatCushionSensorDataManagerChangeNotifier({
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
