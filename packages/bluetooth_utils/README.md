# 🌀 bluetooth_utils

A modular Bluetooth utility toolkit built with [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus).  
This package is currently designed for internal use within this project, and there is no plan to publish it as a reusable library at this time.

If this is your first time using the toolkit, it's highly recommended to refer to the sample code in the [`example/`](example) directory, which demonstrates the basic usage of each module.

---

# 📁 Project Structure Overview

## 🧩 `presentation` – Bluetooth UI Layer

This layer includes common UI components for Bluetooth interactions:
- **`is_on`**: Checks whether the user's Bluetooth is enabled.
- **`others`**: Additional UI modules for various Bluetooth-related functionalities.
- **`quick_connection`**: Provides a fast and user-friendly interface to scan for and connect to nearby Bluetooth devices.
- **`theme`**: Handles Bluetooth-related theming and style management.

---

## 🔧 `services` – Bluetooth Service Logic Layer

This layer encapsulates the logic and operations related to Bluetooth services:
- **`application`**: Sets up commonly used Bluetooth service flows for the project with minimal configuration.
- **`devices`**: Manages the connection and interaction logic with `BluetoothDevice` instances.
- **`services`**: Handles the parsing and management of `List<BluetoothService>` objects.
