import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';

import 'seat_cushion_units_manager.dart';

class SeatCushionUnitsChangeNotifier extends ChangeNotifier {
  @protected
  final SeatCushionUnitsManagerChangeNotifier seatCushionUnitsManagerChangeNotifier;
  final SeatCushionType type;
  late final StreamSubscription _subscription;
  Iterable<SeatCushionUnit>? get units => seatCushionUnitsManagerChangeNotifier.dataList.where((e) => e.type == type).firstOrNull?.units;
  Point<double>? get ischiumPosition => seatCushionUnitsManagerChangeNotifier.dataList.where((e) => e.type == type).firstOrNull?.ischiumPosition();
  SeatCushionUnitsChangeNotifier({
    required this.type,
    required this.seatCushionUnitsManagerChangeNotifier,
  }) {
    seatCushionUnitsManagerChangeNotifier.addListener(notifyListeners);
  }
  @override
  void dispose() {
    seatCushionUnitsManagerChangeNotifier.removeListener(notifyListeners);
    super.dispose();
  }
}
