import 'package:flutter/widgets.dart';

class LineChartChangeNotifier<X> extends ChangeNotifier {
  LineChartChangeNotifier({
    required X? x,
  }) : _x = x;

  X? _x;
  X? get x => _x;
  set x(X? newX) {
    if(_x == newX) return;
    _x = newX;
    notifyListeners();
  }

  bool _isTouched = false;
  bool get isTouched => _isTouched;
  set isTouched(bool newIsTouched) {
    if(_isTouched == newIsTouched) return;
    _isTouched = newIsTouched;
    notifyListeners();
  }

  @protected
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  @override
  void notifyListeners() => super.notifyListeners();
}
