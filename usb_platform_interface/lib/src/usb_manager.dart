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
  Future<bool> hasAccessoryPermission(UsbAccessory accessory);
  Future<bool> hasDevicePermission(UsbDevice device);
  Future<bool> requestAccessoryPermission(UsbAccessory accessory);
  Future<bool> requestDevicePermission(UsbDevice device);
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
  Future<bool> hasAccessoryPermission(UsbAccessory accessory) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasDevicePermission(UsbDevice device) {
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    throw UnimplementedError();
  }

  @override
  Future<bool> requestAccessoryPermission(UsbAccessory accessory) {
    throw UnimplementedError();
  }

  @override
  Future<bool> requestDevicePermission(UsbDevice device) {
    throw UnimplementedError();
  }
}
