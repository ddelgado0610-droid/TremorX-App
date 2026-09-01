import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  StreamSubscription<List<ScanResult>>? _scanSubscription;

  final List<ScanResult> _scanResults = [];

  List<ScanResult> get scanResults =>
      List.unmodifiable(_scanResults);

  /// Starts a BLE scan for nearby devices.
  Future<List<ScanResult>> scanForDevices() async {
    _scanResults.clear();

    // Wait until Bluetooth is turned on.
    await FlutterBluePlus.adapterState
        .where((state) => state == BluetoothAdapterState.on)
        .first;

    // Listen for devices found during the scan.
    _scanSubscription =
        FlutterBluePlus.onScanResults.listen(
      (results) {
        _scanResults
          ..clear()
          ..addAll(results);
      },
      onError: (error) {
        print('BLE scan error: $error');
      },
    );

    // Start scanning for 10 seconds.
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
    );

    // Wait until the scan finishes.
    await FlutterBluePlus.isScanning
        .where((scanning) => scanning == false)
        .first;

    await _scanSubscription?.cancel();
    _scanSubscription = null;

    return scanResults;
  }

  /// Connects to a selected BLE device.
  Future<void> connectToDevice(
    BluetoothDevice device,
  ) async {
    await device.connect();
  }

  /// Disconnects from a BLE device.
  Future<void> disconnectFromDevice(
    BluetoothDevice device,
  ) async {
    await device.disconnect();
  }

  void dispose() {
    _scanSubscription?.cancel();
  }
}