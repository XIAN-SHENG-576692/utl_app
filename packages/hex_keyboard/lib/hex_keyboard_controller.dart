import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Controller class for a custom hexadecimal keyboard input.
/// Manages text editing, focus behavior, and input callbacks.
class HexKeyboardController extends ChangeNotifier {
  // Controller for managing the text field content.
  late final TextEditingController textController;

  // Focus node for handling keyboard focus events.
  late final FocusNode focusNode;

  // Callback when the text changes.
  @protected
  final void Function(String)? onChanged;

  // Callback when the enter key is pressed.
  @protected
  final void Function(String)? onEnter;

  /// Constructor to initialize controller, focus node and optional initial value.
  HexKeyboardController({String? initialValue, this.onChanged, this.onEnter}) {
    textController = TextEditingController(text: initialValue ?? '');
    focusNode = FocusNode();

    // Hide the system keyboard when the input gains focus.
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(Duration.zero, () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        });
      }
    });

    // Notify whenever text is changed and convert to uppercase.
    textController.addListener(() {
      onChanged?.call(textController.text.toUpperCase());
    });
  }

  /// Getter for current input text.
  String get text => textController.text;

  /// Setter to update the input text.
  set text(String value) {
    textController.text = value.toUpperCase(); // Always store as uppercase.
    _moveCursorToEnd(); // Move cursor to the end.
    notifyListeners(); // Notify widgets listening to this controller.
    onChanged?.call(textController.text); // Trigger text change callback.
  }

  /// Calls the `onEnter` callback with the current input.
  void enter() {
    onEnter?.call(textController.text);
  }

  /// Clears the input text and notifies listeners.
  void clear() {
    textController.clear();
    notifyListeners();
    onChanged?.call(textController.text);
  }

  /// Deletes one character before the cursor or the selected text.
  void backspace() {
    final value = textController.value;
    final sel = value.selection;
    if (sel.start == 0 && sel.end == 0) return; // No text to delete.

    final newText = value.text.replaceRange(
      sel.isCollapsed ? sel.start - 1 : sel.start,
      sel.end,
      '',
    );

    final newOffset = sel.isCollapsed ? sel.start - 1 : sel.start;

    textController.value = TextEditingValue(
      text: newText.toUpperCase(),
      selection: TextSelection.collapsed(
        offset: newOffset.clamp(0, newText.length),
      ),
    );

    notifyListeners();
    onChanged?.call(textController.text);
  }

  /// Inserts a hexadecimal character at the current cursor position.
  void insert(String hexChar) {
    final value = textController.value;
    final sel = value.selection;

    final newText = value.text.replaceRange(sel.start, sel.end, hexChar);

    final newOffset = sel.start + hexChar.length;

    textController.value = TextEditingValue(
      text: newText.toUpperCase(),
      selection: TextSelection.collapsed(offset: newOffset),
    );

    notifyListeners();
    onChanged?.call(textController.text);
  }

  /// Sets the cursor to a specific offset.
  void setCursor(int offset) {
    final length = textController.text.length;
    final safeOffset = offset.clamp(0, length);
    textController.selection = TextSelection.collapsed(offset: safeOffset);
  }

  /// Moves the cursor to the end of the text.
  void _moveCursorToEnd() {
    final len = textController.text.length;
    textController.selection = TextSelection.collapsed(offset: len);
  }

  /// Cleans up the controller and focus node when no longer needed.
  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
