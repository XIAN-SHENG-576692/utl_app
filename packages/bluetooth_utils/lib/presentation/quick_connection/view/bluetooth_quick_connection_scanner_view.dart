part of '../bluetooth_quick_connection.dart';

class BluetoothQuickConnectionScannerView extends StatelessWidget {
  const BluetoothQuickConnectionScannerView({super.key});
  @override
  Widget build(BuildContext context) {
    final scanner = context.read<BluetoothQuickConnectionScannerChangeNotifier>();
    return RefreshIndicator(
      onRefresh: scanner.refresh,
      child: Selector<BluetoothQuickConnectionScannerChangeNotifier, int>(
        selector: (context, scanner) => scanner.filteredScanResultsBuffer.length,
        builder: (context, length, _) {
          return ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<_BluetoothQuickConnectionScannerDeviceTileChangeNotifier>(
                create: (_) => _BluetoothQuickConnectionScannerDeviceTileChangeNotifier(scanner: scanner, index: index),
                child: _BluetoothQuickConnectionScannerDeviceTile(),
              );
            },
          );
        },
      ),
    );
  }
}
