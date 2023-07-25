import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'usb_accessory.dart';
import 'usb_device.dart';

abstract class UsbManager extends PlatformInterface {
  /// Constructs a UsbManager.
  UsbManager() : super(token: _token);

  static final Object _token = Object();

  static UsbManager _instance = _UsbManager();

  /// The default instance of [UsbManager] to use.
  static UsbManager get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UsbManager] when
  /// they register themselves.
  static set instance(UsbManager instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<UsbDevice> get deviceAttached;
  Stream<UsbDevice> get deviceDetached;

  Future<void> initialize();
  Future<List<UsbAccessory>> getAccessories();
  Future<Map<String, UsbDevice>> getDevices();
  Future<bool> hasAccessoryPermission(UsbAccessory usbAccessory);
  Future<bool> hasDevicePermission(UsbDevice usbDevice);
  Future<bool> requestAccessoryPermission(UsbAccessory usbAccessory);
  Future<bool> requestDevicePermission(UsbDevice usbDevice);
}

class _UsbManager extends UsbManager {
  @override
  Stream<UsbDevice> get deviceAttached => throw UnimplementedError();

  @override
  Stream<UsbDevice> get deviceDetached => throw UnimplementedError();

  @override
  Future<List<UsbAccessory>> getAccessories() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, UsbDevice>> getDevices() {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasAccessoryPermission(UsbAccessory usbAccessory) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasDevicePermission(UsbDevice usbDevice) {
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    throw UnimplementedError();
  }

  @override
  Future<bool> requestAccessoryPermission(UsbAccessory usbAccessory) {
    throw UnimplementedError();
  }

  @override
  Future<bool> requestDevicePermission(UsbDevice usbDevice) {
    throw UnimplementedError();
  }
}
