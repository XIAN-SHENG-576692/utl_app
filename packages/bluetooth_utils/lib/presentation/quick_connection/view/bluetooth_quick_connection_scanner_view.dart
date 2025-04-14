part of '../bluetooth_quick_connection.dart';

/// A stateless widget that displays a refreshable list of scanned Bluetooth devices.
///
/// This widget listens to a [BluetoothQuickConnectionScannerChangeNotifier] from the context,
/// allowing the UI to rebuild when the list of filtered scan results changes.
/// Each scanned device is rendered via a separate tile widget with its own change notifier.
class BluetoothQuickConnectionScannerView extends StatelessWidget {
  const BluetoothQuickConnectionScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the scanner logic from the context.
    final scanner = context.read<BluetoothQuickConnectionScannerChangeNotifier>();

    // A pull-to-refresh indicator that triggers the scanner's refresh method when activated.
    return RefreshIndicator(
      onRefresh: scanner.refresh,

      // A Selector widget listens for changes to the number of filtered scan results.
      // Only rebuilds the ListView when the length changes, improving performance.
      child: Selector<BluetoothQuickConnectionScannerChangeNotifier, int>(
        selector: (context, scanner) => scanner.filteredScanResultsBuffer.length,
        builder: (context, length, _) {
          return ListView.builder(
            itemCount: length,

            // For each scan result, a new provider is created for its corresponding tile.
            // This allows each device tile to independently react to its own state changes.
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier>(
                create: (_) => _BluetoothQuickConnectionScannerDeviceTileChangeNotifier(
                  scanner: scanner,
                  index: index,
                ),
                child: _BluetoothQuickConnectionScannerDeviceTile(),
              );
            },
          );
        },
      ),
    );
  }
}
