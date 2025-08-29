import 'package:flutter/widgets.dart';

import '../../../../domain/entity/electrochemical_entity.dart';

enum ElectrochemicalLineChartMode {
  ca,
  cv,
  dpv,
  eis0,
  eis1,
}

class ElectrochemicalLineChartChangeNotifier extends ChangeNotifier {
  ElectrochemicalLineChartMode _mode;
  List<ElectrochemicalEntity> _entities;
  bool _isTouched = false;
  double? _x;

  ElectrochemicalLineChartChangeNotifier({
    required ElectrochemicalLineChartMode mode,
    List<ElectrochemicalEntity>? entities,
  })  : _mode = mode,
        _entities = entities ?? [];

  // mode getter and setter
  ElectrochemicalLineChartMode get mode => _mode;
  updateMode(ElectrochemicalLineChartMode newMode) {
    if (_mode != newMode) {
      _mode = newMode;
      notifyListeners();
    }
  }

  // entities getter
  List<ElectrochemicalEntity> get entities => _entities.where((e) {
    switch(_mode) {
      case ElectrochemicalLineChartMode.ca:
        return e.header.type == ElectrochemicalType.ca;
      case ElectrochemicalLineChartMode.cv:
        return e.header.type == ElectrochemicalType.cv;
      case ElectrochemicalLineChartMode.dpv:
        return e.header.type == ElectrochemicalType.dpv;
      case ElectrochemicalLineChartMode.eis0:
        // TODO: Handle this case.
        return false;
      case ElectrochemicalLineChartMode.eis1:
        // TODO: Handle this case.
        return false;
    }
  }).toList(growable: false);

  // x getter and setter
  double? get x => _x;
  updateX(double? newX) {
    if (_x != newX) {
      _x = newX;
      notifyListeners();
    }
  }

  // isTouched setter
  updateIsTouched(bool newIsTouched) {
    if (_isTouched != newIsTouched) {
      _isTouched = newIsTouched;
      notifyListeners();
    }
  }

  // headers getter
  List<ElectrochemicalHeader> get headers => _entities.map((e) => e.header).toList(growable: false);

  // Optional: helper methods
  void updateEntities(List<ElectrochemicalEntity> newEntities) {
    _entities = newEntities;
    notifyListeners();
  }
}
