import 'dart:async';
import 'package:flutter/material.dart';
import 'hex_keyboard_manager.dart';

/// A custom hexadecimal keyboard widget that integrates with HexKeyboardManager.
/// Provides 0–F input buttons, along with optional icon buttons for backspace, clear, and enter.
class HexKeyboard extends StatelessWidget {
  @protected
  final HexKeyboardManager manager; // Central manager to send key actions.
  @protected
  final Color? backgroundColor;     // Optional background color of the keyboard.
  @protected
  final Icon? backspaceIcon;        // Optional icon for backspace button.
  @protected
  final Icon? clearIcon;            // Optional icon for clear button.
  @protected
  final Icon? enterIcon;            // Optional icon for enter button.

  const HexKeyboard({
    super.key,
    required this.manager,
    this.backgroundColor,
    this.backspaceIcon,
    this.clearIcon,
    this.enterIcon,
  });

  // Delay and interval for repeatable buttons (like backspace).
  static const _repeatDelay = Duration(milliseconds: 500);
  static const _repeatRate = Duration(milliseconds: 50);

  @override
  Widget build(BuildContext context) {
    // Construct each row of the keyboard with keys and optional action buttons.
    final List<List<Widget>> rows = [
      _buildRow(['0', '1', '2', '3'], child: backspaceIcon ?? const Icon(Icons.backspace, color: Colors.yellow), repeat: true, onIconPressed: manager.backspace),
      _buildRow(['4', '5', '6', '7'], child: clearIcon ?? const Icon(Icons.clear_all, color: Colors.red), onIconPressed: manager.clear),
      _buildRow(['8', '9', 'A', 'B'], spacer: true),
      _buildRow(['C', 'D', 'E', 'F'], child: enterIcon ?? const Icon(Icons.send, color: Colors.green), onIconPressed: manager.enter),
    ];

    // Wrap rows into a styled container.
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: rows.map((children) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children.map((child) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: child,
              ),
            )).toList(),
          ),
        )).toList(),
      ),
    );
  }

  /// Builds a row of hex buttons, with an optional icon button (e.g., backspace).
  List<Widget> _buildRow(
      List<String> keys, {
      Widget? child,
      VoidCallback? onIconPressed,
      bool spacer = false,
      bool repeat = false,
  }) {
    // Create the hex key buttons.
    final buttons = keys.map<Widget>((k) => ElevatedButton(
      onPressed: () => manager.insert(k),
      child: Text(k),
    )).toList();

    // Add an icon button or spacer to the row if specified.
    if (child != null && onIconPressed != null) {
      buttons.add(_buildKey(child, onIconPressed, repeat));
    } else if (spacer) {
      buttons.add(const SizedBox.shrink()); // Empty space filler.
    }

    return buttons;
  }

  /// Returns a standard or repeatable button based on [repeat] flag.
  Widget _buildKey(Widget child, VoidCallback onPressed, bool repeat) {
    if (!repeat) {
      return ElevatedButton(onPressed: onPressed, child: child);
    }
    return _RepeatableButton(onRepeatPressed: onPressed, child: child);
  }
}

/// A button that repeats its onPressed action while being held down.
/// Used for backspace to continuously delete.
class _RepeatableButton extends StatefulWidget {
  @protected
  final Widget child;                 // Displayed icon or label.
  @protected
  final VoidCallback onRepeatPressed; // Callback to repeat while pressed.

  const _RepeatableButton({required this.child, required this.onRepeatPressed});

  @override
  State<_RepeatableButton> createState() => _RepeatableButtonState();
}

class _RepeatableButtonState extends State<_RepeatableButton> {
  Timer? _timer;

  /// Begins a delayed and then repeating action.
  void _startRepeat() {
    widget.onRepeatPressed(); // Immediate first press.
    _timer = Timer(HexKeyboard._repeatDelay, () {
      _timer = Timer.periodic(HexKeyboard._repeatRate, (_) => widget.onRepeatPressed());
    });
  }

  /// Stops the repeating action.
  void _stopRepeat() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) => _startRepeat(),
      onPanEnd: (_) => _stopRepeat(),
      onPanCancel: () => _stopRepeat(),
      child: ElevatedButton(
        onPressed: () {}, // GestureDetector handles press; keep disabled here.
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _stopRepeat();
    super.dispose();
  }
}
