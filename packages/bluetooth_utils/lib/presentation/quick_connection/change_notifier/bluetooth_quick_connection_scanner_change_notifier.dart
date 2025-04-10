part of '../bluetooth_quick_connection.dart';

/// This class represents a scan result, augmented with dynamic fields like RSSI updates
/// and connectability tracking. It listens to RSSI and connection state changes.
class ScanResultBuffer {
  final VoidCallback _notifyListeners; // Function to notify UI listeners
  final BluetoothDevice bluetoothDevice;

  late final Timer _readRssiTimer;     // Periodically reads RSSI
  int _rssi;
  int get rssi => _rssi;
  set rssi(int newRssi) {
    if (_rssi == newRssi) return;
    _rssi = newRssi;
    _notifyListeners();
  }

  final bool system; // Indicates if the device is system-level known

  bool _connectable;
  bool get connectable => _connectable;
  set connectable(bool newConnectable) {
    if (_connectable == newConnectable) return;
    _connectable = newConnectable;
    _notifyListeners();
  }

  late final StreamSubscription _connectionStateSubscription;

  String get deviceName => bluetoothDevice.platformName;
  String get deviceId => bluetoothDevice.remoteId.str;
  bool get isConnected => bluetoothDevice.isConnected;

  /// Constructor that sets up RSSI polling and listens for connection state changes.
  ScanResultBuffer({
    required this.bluetoothDevice,
    required int rssi,
    required this.system,
    required bool connectable,
    required VoidCallback notifyListeners,
  })  : _rssi = rssi,
        _connectable = connectable,
        _notifyListeners = notifyListeners {
          _readRssiTimer = Timer.periodic(
            const Duration(milliseconds: 100),
            (timer) async {
              if (!isConnected) return;
              try {
                final rssi = await bluetoothDevice.readRssi();
                if (_rssi == rssi) return;
                _rssi = rssi;
                _notifyListeners();
              } catch(e) {}
            },
          );
          _connectionStateSubscription = bluetoothDevice.connectionState.listen((_) {
            _notifyListeners();
          });
        }

  // Override equality based on Bluetooth device identity
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ScanResultBuffer &&
              runtimeType == other.runtimeType &&
              bluetoothDevice == other.bluetoothDevice;

  // Cancel all subscriptions and timers when disposing this buffer
  void cancel() {
    _connectionStateSubscription.cancel();
    _readRssiTimer.cancel();
  }
}

/// A ChangeNotifier that manages Bluetooth scanning and filtered results.
/// Provides reactive updates to UI when scanning results or filter options change.
class BluetoothQuickConnectionScannerChangeNotifier extends ChangeNotifier {

  final bool Function(ScanResultBuffer buffer) displayFilter;
  final Duration? startScanTimeout;

  BluetoothQuickConnectionScannerChangeNotifier({
    required this.displayFilter,
    this.startScanTimeout,
  }) {
    // Listen to scan results and populate buffer with wrapped ScanResultBuffer
    _scanResultsSubscriptions = FlutterBluePlus.scanResults.listen((scanResults) {
      _scanResultsBuffer.addAll(scanResults
          .skip(_scanResultsBuffer.length)
          .map((r) => ScanResultBuffer(
        bluetoothDevice: r.device,
        rssi: r.rssi,
        system: false,
        connectable: r.advertisementData.connectable,
        notifyListeners: notifyListeners,
      )));
      notifyListeners();
    });
  }

  // Raw list of all scan results
  List<ScanResultBuffer> _scanResultsBuffer = [];

  // Filtered list of results shown to the UI
  List<ScanResultBuffer> get filteredScanResultsBuffer =>
      _scanResultsBuffer.where(displayFilter).toList(growable: false);

  // Subscription to FlutterBluePlus scan results
  late final StreamSubscription _scanResultsSubscriptions;

  /// Refresh the scan results by clearing old data and restarting the scan.
  /// Also retrieves known system devices.
  Future refresh() async {
    if (FlutterBluePlus.isScanningNow) return;
    final devices = await FlutterBluePlus.systemDevices([]);

    final newBuffer = devices.map((d) {
      final b = _scanResultsBuffer.where((b) => b.bluetoothDevice == d).firstOrNull;
      return ScanResultBuffer(
        bluetoothDevice: d,
        rssi: b?.rssi ?? 0,
        system: true,
        connectable: b?.connectable ?? false,
        notifyListeners: notifyListeners,
      );
    }).toList();

    for (final b in _scanResultsBuffer) {
      b.cancel(); // Cancel timers and subscriptions
    }

    _scanResultsBuffer.clear();
    _scanResultsBuffer = newBuffer;

    return FlutterBluePlus.startScan(
      timeout: startScanTimeout,
      continuousUpdates: true,
    );
  }

  /// Properly dispose resources and stop all timers/subscriptions
  @override
  void dispose() {
    for (final b in _scanResultsBuffer) {
      b.cancel();
    }
    _scanResultsBuffer.clear();
    super.dispose();
  }
}
