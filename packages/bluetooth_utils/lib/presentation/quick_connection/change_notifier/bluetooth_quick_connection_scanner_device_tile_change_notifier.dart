part of '../bluetooth_quick_connection.dart';

/// A ChangeNotifier for managing a single Bluetooth device tile in the UI.
///
/// It listens to the parent [BluetoothQuickConnectionScannerChangeNotifier]
/// and relays updates related to the specific device at the given [index]
/// in the filtered scan results.
class _BluetoothQuickConnectionScannerDeviceTileChangeNotifier extends ChangeNotifier {
  final BluetoothQuickConnectionScannerChangeNotifier scanner; // The main scanner managing all devices
  final int index; // Index of this device in the filtered results

  /// Gets the corresponding [ScanResultBuffer] from the parent scanner
  ScanResultBuffer get buffer => scanner.filteredScanResultsBuffer.elementAt(index);

  /// Constructor sets up a listener on the parent scanner to forward updates
  _BluetoothQuickConnectionScannerDeviceTileChangeNotifier({
    required this.scanner,
    required this.index,
  }) {
    scanner.addListener(notifyListeners); // When scanner changes, notify UI
  }

  /// Clean up by removing listener from parent notifier
  @override
  void dispose() {
    scanner.removeListener(notifyListeners);
    super.dispose();
  }
}
