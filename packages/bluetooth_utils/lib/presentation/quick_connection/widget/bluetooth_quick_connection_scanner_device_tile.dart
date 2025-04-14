part of '../bluetooth_quick_connection.dart';

/// A small widget that displays the RSSI (signal strength) of a Bluetooth device.
///
/// It listens for changes in RSSI via the ChangeNotifier and updates only when RSSI changes.
class _RssiText extends StatelessWidget {
  const _RssiText({super.key});

  @override
  Widget build(BuildContext context) {
    // Get RSSI value from the buffer using a context selector.
    final rssi = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, int>(
          (b) => b.buffer.rssi,
    );
    return Text(rssi.toString());
  }
}

/// A connection button that allows the user to connect or disconnect a Bluetooth device.
///
/// The icon and action change depending on the current connection state.
/// The button is only enabled when the device is connectable.
class _ConnectionButton extends StatelessWidget {
  const _ConnectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final device = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, BluetoothDevice>(
          (b) => b.buffer.bluetoothDevice,
    );
    final connectable = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, bool>(
          (b) => b.buffer.connectable,
    );
    final isConnected = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, bool>(
          (b) => b.buffer.isConnected,
    );
    final themeData = Theme.of(context);

    // Define the connection action based on the connectable status and current connection state.
    VoidCallback? onPressed = (connectable)
        ? () async {
      try {
        (isConnected) ? await device.disconnect() : await device.connect();
      } catch (e) {
        // Handle connection errors silently
      }
    }
        : null;

    // Icon changes depending on whether the device is currently connected.
    final connectionIcon = (isConnected)
        ? Icon(Icons.bluetooth_disabled)
        : Icon(Icons.bluetooth_connected);

    return IconButton(
      onPressed: onPressed,
      icon: connectionIcon,
      highlightColor: themeData.scaffoldBackgroundColor,
    );
  }
}

/// A single device tile in the Bluetooth quick scan list.
///
/// Displays:
/// - Device name and ID
/// - RSSI signal strength
/// - Connection status button
/// The tile color changes based on whether the device is connected.
class _BluetoothQuickConnectionScannerDeviceTile extends StatelessWidget {
  const _BluetoothQuickConnectionScannerDeviceTile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // Get scan result data (device info + state) from the ChangeNotifier.
    final buffer = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, ScanResultBuffer>(
          (b) => b.buffer,
    );
    final isConnected = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, bool>(
          (b) => b.buffer.isConnected,
    );

    // Create leading/trailing widgets.
    final rssiText = _RssiText();
    final connectionButton = _ConnectionButton();

    // Determine background color based on connection state.
    final backgroundColor = (isConnected)
        ? themeData.bluetoothConnectedDeviceTileColor
        : themeData.bluetoothDisconnectedDeviceTileColor;

    final deviceName = buffer.deviceName;
    final deviceId = buffer.deviceId;

    // Title includes name (if available) and device ID.
    final title = (deviceName.isNotEmpty)
        ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          deviceName,
          overflow: TextOverflow.ellipsis,
        ),
        Builder(
          builder: (context) {
            return Text(
              deviceId,
              style: Theme.of(context).textTheme.bodySmall,
            );
          },
        ),
      ],
    )
        : Text(deviceId);

    return ListTile(
      leading: rssiText,
      title: title,
      trailing: connectionButton,
      tileColor: backgroundColor,
    );
  }
}
