import 'package:flutter/widgets.dart';
import 'hex_keyboard_controller.dart';

/// Manages which HexKeyboardController is currently active.
/// Allows centralized interaction with the active controller instance.
class HexKeyboardManager extends ChangeNotifier {
  // The currently active HexKeyboardController.
  HexKeyboardController? _activeController;

  /// Sets a HexKeyboardController as the currently active controller.
  /// Also listens to its focus node to trigger UI updates.
  void setActive(HexKeyboardController controller) {
    _activeController = controller;
    _activeController?.focusNode.addListener(notifyListeners);
    notifyListeners(); // Notifies any listening widgets to rebuild.
  }

  /// Clears the current active controller and stops listening to its focus.
  void clearActive() {
    _activeController?.focusNode.removeListener(notifyListeners);
    _activeController = null;
    notifyListeners();
  }

  /// Getter for the current active controller.
  HexKeyboardController? get active => _activeController;

  /// Returns true if the current active controller has keyboard focus.
  bool get hasFocus => _activeController?.focusNode.hasFocus ?? false;

  /// Inserts a key into the active controller's text input.
  void insert(String key) => _activeController?.insert(key);

  /// Sends a backspace command to the active controller.
  void backspace() => _activeController?.backspace();

  /// Clears the input of the active controller.
  void clear() => _activeController?.clear();

  /// Triggers the enter action on the active controller.
  void enter() => _activeController?.enter();
}
