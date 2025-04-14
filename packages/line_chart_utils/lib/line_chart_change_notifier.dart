import 'package:flutter/widgets.dart';

/// A generic ChangeNotifier class to manage the state of a line chart,
/// particularly focusing on the X-axis value and touch interaction state.
///
/// This is useful for coordinating updates to UI widgets whenever the
/// selected X value or touch state changes.
class LineChartChangeNotifier<X> extends ChangeNotifier {
  /// Constructor requires an initial X-axis value, which can be null.
  LineChartChangeNotifier({
    required X? x,
  }) : _x = x;

  // Private field to store the X-axis value.
  X? _x;

  /// Getter for the current X-axis value.
  X? get x => _x;

  /// Setter for the X-axis value.
  /// If the new value is different from the current one,
  /// update it and notify all listeners.
  set x(X? newX) {
    if (_x == newX) return;
    _x = newX;
    notifyListeners();
  }

  // Private flag indicating whether the chart is currently being touched.
  bool _isTouched = false;

  /// Getter to check if the chart is being touched.
  bool get isTouched => _isTouched;

  /// Setter for the touch state.
  /// Notifies listeners only if the state changes.
  set isTouched(bool newIsTouched) {
    if (_isTouched == newIsTouched) return;
    _isTouched = newIsTouched;
    notifyListeners();
  }

  /// Notifies all registered listeners.
  ///
  /// This override is decorated with metadata to improve visibility in
  /// debugging and testing.
  @protected
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  @override
  void notifyListeners() => super.notifyListeners();
}
