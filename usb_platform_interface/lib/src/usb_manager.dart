import 'usb_accessory.dart';
import 'usb_device.dart';
import 'usb_device_connection.dart';
import 'usb_plugin.dart';

abstract interface class USBManager {
  static USBManager? _instance;

  factory USBManager() {
    var instance = _instance;
    if (instance == null) {
      _instance = instance = USBPlugin.instance.createUSBManager();
    }
    return instance;
  }

  Stream<USBDevice> get deviceAttached;
  Stream<USBDevice> get deviceDetached;

  Future<List<USBAccessory>> getAccessories();
  Future<bool> hasAccessoryPermission(USBAccessory accessory);
  Future<bool> requestAccessoryPermission(USBAccessory accessory);
  Future<Map<String, USBDevice>> getDevices();
  Future<bool> hasDevicePermission(USBDevice device);
  Future<bool> requestDevicePermission(USBDevice device);
  Future<USBDeviceConnection> openDevice(USBDevice device);
}
