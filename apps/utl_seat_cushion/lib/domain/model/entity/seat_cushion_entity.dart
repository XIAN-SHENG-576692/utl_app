import 'dart:math';

import 'package:equatable/equatable.dart';

enum SeatCushionType {
  upper,
  lower,
}

class SeatCushionParameters {
  SeatCushionParameters._();

  static const int unitsMaxRow = 8;
  static const int unitsMaxColumn = 31;
  static const int unitsMaxIndex = unitsMaxRow * unitsMaxColumn;
  static const double unitsHalfMaxRow = unitsMaxRow / 2;
  static const double unitsHalfMaxColumn = unitsMaxColumn / 2;
  static const double unitWidth = 7.5;
  static const double unitHeight = 10.0;

  static int get forceLength => unitsMaxIndex;
  static const int forceMax = 2500;
  static const int forceMin = 0;
}

class SeatCushionCalculator {
  SeatCushionCalculator._();

  static Point<double> basePosition({
    required SeatCushionEntity entity,
  }) {
    switch(entity.type) {
      case SeatCushionType.upper:
        return Point(0.0, 0.0);
      case SeatCushionType.lower:
        return Point(0.0, 143.0);
    }
  }

  static double ischiumWidth({
    required SeatCushionEntity upper,
    required SeatCushionEntity lower,
  }) {
    if(upper.type != SeatCushionType.upper) throw Exception("ischiumWidth: enter wrong upper.");
    if(lower.type != SeatCushionType.lower) throw Exception("ischiumWidth: enter wrong lower.");
    final upperP = upper.ischiumPosition() + basePosition(entity: upper);
    final lowerP = lower.ischiumPosition() + basePosition(entity: lower);
    final dx = (lowerP.x - upperP.x);
    final dy = (lowerP.y - upperP.y);
    return sqrt(pow(dx, 2) + pow(dy, 2));
  }

}

class SeatCushionUnit extends Equatable {

  SeatCushionUnit({
    required this.index,
    required this.force,
  });

  int index;
  int force;

  int get row => index % SeatCushionParameters.unitsMaxRow;
  int get column => index ~/ SeatCushionParameters.unitsMaxRow;

  Point<double> get position => Point(
    (column - SeatCushionParameters.unitsHalfMaxColumn + 0.5) * SeatCushionParameters.unitWidth,
    (row - SeatCushionParameters.unitsHalfMaxRow + 0.5) * SeatCushionParameters.unitHeight,
  );

  @override
  List<Object?> get props => [
    index,
    force,
  ];

}

class SeatCushionEntity extends Equatable {

  const SeatCushionEntity({
    required this.id,
    required this.deviceId,
    required this.forces,
    required this.type,
  });

  final int id;
  final String deviceId;
  final List<int> forces;
  final SeatCushionType type;

  @override
  List<Object?> get props => [id];

  double totalForce() {
    return forces.fold<double>(
      0,
      (init, combine) => init + combine,
    );
  }

  Iterable<SeatCushionUnit> get units => Iterable.generate(SeatCushionParameters.unitsMaxIndex, (index) {
    return SeatCushionUnit(index: index, force: forces[index]);
  });

  Point<double> centerOfForces() {
    return units.fold<Point<double>>(
      Point(0, 0),
      (init, combine) {
        return init + combine.position * combine.force;
      },
    ) * (1 / totalForce());
  }

  Point<double> ischiumPosition() {
    final units = this.units.toList(growable: false)..sort((a, b) => b.force.compareTo(a.force));
    var leverage = Point<double>(0, 0);
    var total = 0.0;
    for (var item in units.indexed) {
      final index = item.$1;
      final unit = item.$2;
      final force = (unit.force < SeatCushionParameters.forceMax)
        ? unit.force
        : SeatCushionParameters.forceMax;
      leverage += unit.position * unit.force;
      total += unit.force;
      if(force == SeatCushionParameters.forceMax && index >= 9) break;
    }
    return leverage * (1 / total);
  }

}
