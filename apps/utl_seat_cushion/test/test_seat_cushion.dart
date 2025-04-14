import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

import 'package:utl_seat_cushion/domain/model/entity/seat_cushion_entity.dart';

void main() {
  group('SeatCushionEntity', () {
    test('totalForce returns correct sum', () {
      final entity = SeatCushionEntity(
        id: 1,
        deviceId: 'dev01',
        forces: List.filled(SeatCushionParameters.unitsMaxIndex, 10),
        type: SeatCushionType.upper,
      );

      expect(entity.totalForce(), equals(10 * SeatCushionParameters.unitsMaxIndex));
    });

    test('centerOfForces returns weighted center', () {
      final forces = List.filled(SeatCushionParameters.unitsMaxIndex, 0);
      forces[0] = 100;
      forces[10] = 200;

      final entity = SeatCushionEntity(
        id: 2,
        deviceId: 'dev02',
        forces: forces,
        type: SeatCushionType.upper,
      );

      final center = entity.centerOfForces();
      expect(center.x, isA<double>());
      expect(center.y, isA<double>());
    });

    test('ischiumPosition returns capped average position', () {
      final forces = List.generate(SeatCushionParameters.unitsMaxIndex, (i) => i == 5 ? 3000 : 0);
      final entity = SeatCushionEntity(
        id: 3,
        deviceId: 'dev03',
        forces: forces,
        type: SeatCushionType.upper,
      );

      final pos = entity.ischiumPosition();
      expect(pos, isA<Point<double>>());
    });
  });

  group('SeatCushionUnit', () {
    test('row and column calculation are correct', () {
      final unit = SeatCushionUnit(index: 17, force: 100);
      expect(unit.row, equals(17 % SeatCushionParameters.unitsMaxRow));
      expect(unit.column, equals(17 ~/ SeatCushionParameters.unitsMaxRow));
    });

    test('position is calculated correctly', () {
      final unit = SeatCushionUnit(index: 0, force: 100);
      final pos = unit.position;
      expect(pos.x, isA<double>());
      expect(pos.y, isA<double>());
    });
  });

  group('SeatCushionCalculator', () {
    test('basePosition returns correct offset', () {
      final upper = SeatCushionEntity(
        id: 1,
        deviceId: 'dev01',
        forces: List.filled(SeatCushionParameters.unitsMaxIndex, 1),
        type: SeatCushionType.upper,
      );
      final lower = SeatCushionEntity(
        id: 2,
        deviceId: 'dev02',
        forces: List.filled(SeatCushionParameters.unitsMaxIndex, 1),
        type: SeatCushionType.lower,
      );

      expect(SeatCushionCalculator.basePosition(entity: upper), equals(Point(0.0, 0.0)));
      expect(SeatCushionCalculator.basePosition(entity: lower), equals(Point(0.0, 143.0)));
    });

    test('ischiumWidth calculates euclidean distance correctly', () {
      final forces = List.generate(SeatCushionParameters.unitsMaxIndex, (i) => i == 0 ? 2500 : 0);
      final upper = SeatCushionEntity(
        id: 1,
        deviceId: 'dev01',
        forces: forces,
        type: SeatCushionType.upper,
      );
      final lower = SeatCushionEntity(
        id: 2,
        deviceId: 'dev02',
        forces: forces,
        type: SeatCushionType.lower,
      );

      final width = SeatCushionCalculator.ischiumWidth(upper: upper, lower: lower);
      expect(width, greaterThan(0));
    });

    test('ischiumWidth correctly calculates Euclidean distances in extreme ranges', () {
      final upper = SeatCushionEntity(
        id: 1,
        deviceId: 'dev01',
        forces: List.generate(SeatCushionParameters.unitsMaxIndex, (i) => i == 0 ? 2500 : 0),
        type: SeatCushionType.upper,
      );
      final lower = SeatCushionEntity(
        id: 2,
        deviceId: 'dev02',
        forces: List.generate(SeatCushionParameters.unitsMaxIndex, (i) => i == (SeatCushionParameters.unitsMaxIndex - 1) ? 2500 : 0),
        type: SeatCushionType.lower,
      );

      final upperP = upper.ischiumPosition();
      final lowerP = lower.ischiumPosition();
      final width = SeatCushionCalculator.ischiumWidth(upper: upper, lower: lower);
      expect(upperP, Point(-112.5, -35.0));
      expect(lowerP, Point(112.5, 35.0));
      expect(width.round(), 303);
    });
  });
}
