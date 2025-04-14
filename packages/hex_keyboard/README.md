# 🔢 HexKeyboard – A Custom Hexadecimal Input Solution for Flutter
================================================================

A lightweight and reusable Flutter widget that enables precise **hexadecimal (0–F)** input via a **custom on-screen keyboard**. Ideal for embedded interfaces, hardware communication apps, or any system requiring strict hex input formatting.

* * *

# ✨ Features
----------

*   🧩 Modular architecture: controller, input field, and keyboard separated

*   🔠 Accepts only uppercase hexadecimal input (`0–9`, `A–F`)

*   ⌨️ Custom virtual keyboard (no system keyboard)

*   🔁 Long-press backspace support

*   🎨 Fully customizable with your own icons and styling

*   🔄 Easy integration with state management solutions


* * *

# 📦 Folder Structure
-------------------

```plaintext
lib/
├── hex_keyboard_controller.dart     # Controls the input state
├── hex_keyboard_input_field.dart    # TextField for hex input (uses custom keyboard)
├── hex_keyboard_manager.dart        # Manages global keyboard focus & actions
└── hex_keyboard.dart                # UI layout for hex keyboard
```

* * *

# 🚀 Getting Started
------------------

## 1\. Import the files

Copy all four `.dart` files to your project (ideally under `lib/widgets/hex_keyboard/` or similar).

* * *

## 2\. Create a controller & manager

```dart
final HexKeyboardController controller = HexKeyboardController();
final HexKeyboardManager manager = HexKeyboardManager();
```

* * *

## 3\. Add the input field

```dart
HexKeyboardInputField(
  controller: controller,
  manager: manager,
)
```

* * *

## 4\. Place the keyboard somewhere on the screen

```dart
HexKeyboard(
  manager: manager,
  backgroundColor: Colors.black,
  backspaceIcon: Icon(Icons.backspace, color: Colors.yellow),
  clearIcon: Icon(Icons.clear, color: Colors.red),
  enterIcon: Icon(Icons.check, color: Colors.green),
)
```

* * *

# 📂 Example Integration
----------------------

```dart
Column(
  children: [
    HexKeyboardInputField(
      controller: myController,
      manager: myManager,
    ),
    const SizedBox(height: 20),
    HexKeyboard(
      manager: myManager,
    ),
  ],
)
```

* * *

# 🔧 Customization Options
------------------------

| Property | Widget | Description |
| --- | --- | --- |
| `backspaceIcon` | `Icon(Icons.backspace)` | Icon used for backspace |
| `clearIcon` | `Icon(Icons.clear)` | Icon for clearing all input |
| `enterIcon` | `Icon(Icons.check)` | Icon for submitting the value |
| `backgroundColor` | `Colors.black` | Background color of the keyboard |

* * *

# 🧠 Internal Architecture
------------------------

*   **HexKeyboardController**: Wraps a `TextEditingController` and handles logic for insert, delete, clear, and enter.

*   **HexKeyboardManager**: Keeps track of which controller is active and delegates key presses.

*   **HexKeyboardInputField**: A `TextField` that disables the system keyboard and filters input to valid hex only.

*   **HexKeyboard**: On-screen UI keyboard that feeds input into the manager.


* * *

# 📜 License
----------

MIT License © 2025 \[NTUT UTL Lab\]

* * *]()