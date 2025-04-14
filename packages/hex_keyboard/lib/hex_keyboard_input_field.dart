import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'hex_keyboard_controller.dart';
import 'hex_keyboard_manager.dart';

/// A custom input field widget for hexadecimal input.
/// It connects to a HexKeyboardController and registers itself
/// with a HexKeyboardManager to handle input focus and virtual keyboard actions.
class HexKeyboardInputField extends TextField {
  // Manager to handle global keyboard interactions and focus.
  @protected
  final HexKeyboardManager manager;

  HexKeyboardInputField({
    super.key,
    required HexKeyboardController controller,
    required this.manager,
    super.decoration = const InputDecoration(hintText: 'Hex Input'),
    super.style,
    super.strutStyle,
    super.textAlignVertical,
    super.textDirection,
    super.showCursor,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.maxLengthEnforcement,
    super.enabled,
    super.ignorePointers,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorOpacityAnimates,
    super.cursorColor,
    super.cursorErrorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.scrollPadding,
  }) : super(
    // Connect the controller and focus node from HexKeyboardController.
    controller: controller.textController,
    focusNode: controller.focusNode,

    // Allow interaction, but disable the system keyboard.
    readOnly: false,
    obscureText: false,
    enableInteractiveSelection: true,
    keyboardType: TextInputType.none, // Suppress system keyboard.

    // Filter input to accept only valid hex characters and convert to uppercase.
    inputFormatters: [
      _UpperCaseHexFormatter(),
    ],

    // Register this field with the manager when tapped.
    onTap: () {
      manager.setActive(controller);
    },

    // Provide a context menu (e.g. copy/paste) using the platform-native style.
    contextMenuBuilder: (context, editableTextState) {
      return AdaptiveTextSelectionToolbar.buttonItems(
        anchors: editableTextState.contextMenuAnchors,
        buttonItems: [
          ...editableTextState.contextMenuButtonItems, // Include default buttons.
        ],
      );
    },
  );
}

/// A text input formatter that filters non-hex characters
/// and converts input to uppercase hex characters only.
class _UpperCaseHexFormatter extends TextInputFormatter {
  // Regular expression to match valid hexadecimal characters.
  final RegExp _hexRegex = RegExp(r'[0-9a-fA-F]');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Filter and transform input to uppercase hexadecimal string.
    final filtered = newValue.text
        .split('')
        .where((char) => _hexRegex.hasMatch(char))
        .join()
        .toUpperCase();

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}
