import 'dart:async';

import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'usb_pigeon.dart';

final _finalizerAPI = FinalizerHostAPI();
final _managerAPI = USBManagerHostAPI();
final _accessoryAPI = USBAccessoryHostAPI();
final _deviceAPI = USBDeviceHostAPI();
final _configurationAPI = USBConfigurationHostAPI();
final _interfaceAPI = USBInterfaceHostAPI();
final _deviceConnectionAPI = USBDeviceConnectionHostAPI();
final _broadcastReceiver = USBBroadcastReceiverImpl();

final _finalizer = Finalizer<int>((hashCode) => _finalizerAPI.free(hashCode));

abstract class NativeObject {
  final int _hashCode;

  NativeObject(int hashCode) : _hashCode = hashCode {
    _finalizer.attach(this, hashCode);
  }

  @override
  int get hashCode => _hashCode;

  @override
  bool operator ==(Object other) {
    return other is NativeObject && other.hashCode == hashCode;
  }
}

class USBManagerImpl implements USBManager {
  @override
  Stream<USBDevice> get deviceAttached => _broadcastReceiver.deviceAttached;
  @override
  Stream<USBDevice> get deviceDetached => _broadcastReceiver.deviceDetached;

  @override
  Future<List<USBAccessory>> getAccessories() async {
    final hashCodes = await _managerAPI.getAccessories();
    return hashCodes
        .cast<int>()
        .map((hashCode) => USBAccessoryImpl(hashCode))
        .toList();
  }

  @override
  Future<bool> hasAccessoryPermission(USBAccessory accessory) {
    return _managerAPI.hasAccessoryPermission(accessory.hashCode);
  }

  @override
  Future<bool> requestAccessoryPermission(USBAccessory accessory) async {
    final completer = Completer<bool>();
    final subscription = _broadcastReceiver.accessoryPermission.listen((event) {
      if (event.$1 != accessory) {
        return;
      }
      completer.complete(event.$2);
    });
    try {
      await _managerAPI.requestAccessoryPermission(accessory.hashCode);
      final isGranted = await completer.future;
      return isGranted;
    } finally {
      subscription.cancel();
    }
  }

  @override
  Future<Map<String, USBDevice>> getDevices() async {
    final hashCodes = await _managerAPI.getDevices();
    return hashCodes
        .cast<String, int>()
        .map((name, hashCode) => MapEntry(name, USBDeviceImpl(hashCode)));
  }

  @override
  Future<bool> hasDevicePermission(USBDevice device) {
    return _managerAPI.hasDevicePermission(device.hashCode);
  }

  @override
  Future<bool> requestDevicePermission(USBDevice device) async {
    final completer = Completer<bool>();
    final subscription = _broadcastReceiver.devicePermission.listen((event) {
      if (event.$1 != device) {
        return;
      }
      completer.complete(event.$2);
    });
    try {
      await _managerAPI.requestDevicePermission(device.hashCode);
      final isGranted = await completer.future;
      return isGranted;
    } finally {
      subscription.cancel();
    }
  }

  @override
  Future<USBDeviceConnection> openDevice(USBDevice device) async {
    final hashCode = await _managerAPI.openDevice(device.hashCode);
    return USBDeviceConnectionImpl(hashCode);
  }
}

class USBAccessoryImpl extends NativeObject implements USBAccessory {
  USBAccessoryImpl(super.hashCode);

  @override
  Future<String?> getDescription() {
    return _accessoryAPI.getDescription(hashCode);
  }

  @override
  Future<String> getManufacturer() {
    return _accessoryAPI.getManufacturer(hashCode);
  }

  @override
  Future<String> getModel() {
    return _accessoryAPI.getModel(hashCode);
  }

  @override
  Future<String?> getSerial() {
    return _accessoryAPI.getSerial(hashCode);
  }

  @override
  Future<String?> getUri() {
    return _accessoryAPI.getUri(hashCode);
  }

  @override
  Future<String?> getVersion() {
    return _accessoryAPI.getVersion(hashCode);
  }
}

class USBDeviceImpl extends NativeObject implements USBDevice {
  USBDeviceImpl(super.hashCode);

  @override
  Future<USBConfiguration> getConfiguration(int index) async {
    final configurationHashCode =
        await _deviceAPI.getConfiguration(hashCode, index);
    return USBConfigurationImpl(configurationHashCode);
  }

  @override
  Future<int> getConfigurationCount() {
    return _deviceAPI.getConfigurationCount(hashCode);
  }

  @override
  Future<int> getDeviceClass() {
    return _deviceAPI.getDeviceClass(hashCode);
  }

  @override
  Future<String> getDeviceName() {
    return _deviceAPI.getDeviceName(hashCode);
  }

  @override
  Future<int> getDeviceProtocol() {
    return _deviceAPI.getDeviceProtocol(hashCode);
  }

  @override
  Future<int> getDeviceSubClass() {
    return _deviceAPI.getDeviceSubClass(hashCode);
  }

  @override
  Future<USBInterface> getInterface(int index) async {
    final interfaceHashCode = await _deviceAPI.getInterface(hashCode, index);
    return USBInterfaceImpl(interfaceHashCode);
  }

  @override
  Future<int> getInterfaceCount() {
    return _deviceAPI.getInterfaceCount(hashCode);
  }

  @override
  Future<String?> getManufacturerName() {
    return _deviceAPI.getManufacturerName(hashCode);
  }

  @override
  Future<int> getProductId() {
    return _deviceAPI.getProductId(hashCode);
  }

  @override
  Future<String?> getProductName() {
    return _deviceAPI.getProductName(hashCode);
  }

  @override
  Future<String?> getSerialNumber() {
    return _deviceAPI.getSerialNumber(hashCode);
  }

  @override
  Future<int> getVendorId() {
    return _deviceAPI.getVendorId(hashCode);
  }

  @override
  Future<String> getVersion() {
    return _deviceAPI.getVersion(hashCode);
  }
}

class USBConfigurationImpl extends NativeObject implements USBConfiguration {
  USBConfigurationImpl(super.hashCode);

  @override
  Future<int> getId() {
    return _configurationAPI.getId(hashCode);
  }

  @override
  Future<USBInterface> getInterface(int index) async {
    final interfaceHashCode =
        await _configurationAPI.getInterface(hashCode, index);
    return USBInterfaceImpl(interfaceHashCode);
  }

  @override
  Future<int> getInterfaceCount() {
    return _configurationAPI.getInterfaceCount(hashCode);
  }

  @override
  Future<bool> getIsRemoteWakeup() {
    return _configurationAPI.getIsRemoteWakeup(hashCode);
  }

  @override
  Future<bool> getIsSelfPowered() {
    return _configurationAPI.getIsSelfPowered(hashCode);
  }

  @override
  Future<int> getMaxPower() {
    return _configurationAPI.getMaxPower(hashCode);
  }

  @override
  Future<String?> getName() {
    return _configurationAPI.getName(hashCode);
  }
}

class USBInterfaceImpl extends NativeObject implements USBInterface {
  USBInterfaceImpl(super.hashCode);

  @override
  Future<int> getAlternateSetting() {
    return _interfaceAPI.getAlternateSetting(hashCode);
  }

  @override
  Future<int> getEndpointCount() {
    return _interfaceAPI.getEndpointCount(hashCode);
  }

  @override
  Future<int> getId() {
    return _interfaceAPI.getId(hashCode);
  }

  @override
  Future<int> getInterfaceClass() {
    return _interfaceAPI.getInterfaceClass(hashCode);
  }

  @override
  Future<int> getInterfaceProtocol() {
    return _interfaceAPI.getInterfaceProtocol(hashCode);
  }

  @override
  Future<int> getInterfaceSubclass() {
    return _interfaceAPI.getInterfaceSubclass(hashCode);
  }

  @override
  Future<String?> getName() {
    return _interfaceAPI.getName(hashCode);
  }
}

class USBDeviceConnectionImpl extends NativeObject
    implements USBDeviceConnection {
  USBDeviceConnectionImpl(super.hashCode);

  @override
  Future<int> getFileDescriptor() {
    return _deviceConnectionAPI.getFileDescriptor(hashCode);
  }

  @override
  Future<void> close() {
    return _deviceConnectionAPI.close(hashCode);
  }
}

class USBBroadcastReceiverImpl implements USBBroadcastReceiverFlutterAPI {
  final StreamController<USBAccessory> accessoryAttachedController;
  final StreamController<USBAccessory> accessoryDetachedController;
  final StreamController<(USBAccessory, bool)> accessoryPermissionController;
  final StreamController<USBDevice> deviceAttachedController;
  final StreamController<USBDevice> deviceDetachedController;
  final StreamController<(USBDevice, bool)> devicePermissionController;

  USBBroadcastReceiverImpl()
      : accessoryAttachedController = StreamController.broadcast(),
        accessoryDetachedController = StreamController.broadcast(),
        accessoryPermissionController = StreamController.broadcast(),
        deviceAttachedController = StreamController.broadcast(),
        deviceDetachedController = StreamController.broadcast(),
        devicePermissionController = StreamController.broadcast() {
    USBBroadcastReceiverFlutterAPI.setUp(this);
  }

  Stream<USBAccessory> get accessoryAttached =>
      accessoryAttachedController.stream;
  Stream<USBAccessory> get accessoryDetached =>
      accessoryDetachedController.stream;
  Stream<(USBAccessory, bool)> get accessoryPermission =>
      accessoryPermissionController.stream;
  Stream<USBDevice> get deviceAttached => deviceAttachedController.stream;
  Stream<USBDevice> get deviceDetached => deviceDetachedController.stream;
  Stream<(USBDevice, bool)> get devicePermission =>
      devicePermissionController.stream;

  @override
  void onAccessoryAttached(int hashCode) {
    final accessory = USBAccessoryImpl(hashCode);
    accessoryAttachedController.add(accessory);
  }

  @override
  void onAccessoryDetached(int hashCode) {
    final accessory = USBAccessoryImpl(hashCode);
    accessoryDetachedController.add(accessory);
  }

  @override
  void onAccessoryPermission(int hashCode, bool isGranted) {
    final accessory = USBAccessoryImpl(hashCode);
    final event = (accessory, isGranted);
    accessoryPermissionController.add(event);
  }

  @override
  void onDeviceAttached(int hashCode) {
    final device = USBDeviceImpl(hashCode);
    deviceAttachedController.add(device);
  }

  @override
  void onDeviceDetached(int hashCode) {
    final device = USBDeviceImpl(hashCode);
    deviceDetachedController.add(device);
  }

  @override
  void onDevicePermission(int hashCode, bool isGranted) {
    final device = USBDeviceImpl(hashCode);
    final event = (device, isGranted);
    devicePermissionController.add(event);
  }
}
