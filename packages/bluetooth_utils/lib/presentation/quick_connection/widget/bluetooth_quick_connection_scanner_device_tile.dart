part of '../bluetooth_quick_connection.dart';

class _RssiText extends StatelessWidget {
  const _RssiText({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final rssi = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, int>((b) => b.buffer.rssi);
    return Text(rssi.toString());
  }
}

class _ConnectionButton extends StatelessWidget {
  const _ConnectionButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final device = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, BluetoothDevice>((b) => b.buffer.bluetoothDevice);
    final connectable = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, bool>((b) => b.buffer.connectable);
    final isConnected = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, bool>((b) => b.buffer.isConnected);
    final themeData = Theme.of(context);
    VoidCallback? onPressed = (connectable)
        ? () async {
      try{
        (isConnected)
            ? await device.disconnect()
            : await device.connect();
      } catch(e) {}
    }
        : null;
    final connectionIcon = (isConnected)
        ? Icon(
      Icons.bluetooth_disabled,
    )
        : Icon(
      Icons.bluetooth_connected,
    );
    return IconButton(
      onPressed: onPressed,
      icon: connectionIcon,
      highlightColor: themeData.scaffoldBackgroundColor,
    );
  }
}

class _BluetoothQuickConnectionScannerDeviceTile extends StatelessWidget {
  const _BluetoothQuickConnectionScannerDeviceTile({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final buffer = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, ScanResultBuffer>((b) => b.buffer);
    final isConnected = context.select<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier, bool>((b) => b.buffer.isConnected);
    final rssiText = _RssiText();
    final connectionButton = _ConnectionButton();
    final backgroundColor = (isConnected)
        ? themeData.bluetoothConnectedDeviceTileColor
        : themeData.bluetoothDisconnectedDeviceTileColor;
    final deviceName = buffer.deviceName;
    final deviceId = buffer.deviceId;
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
