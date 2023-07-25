import 'dart:async';

import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_usb_accessory.dart';
import 'my_usb_device.dart';

final myUsbBroadcastReceiverApi = MyUsbBroadcastReceiverApi();

class MyUsbBroadcastReceiverApi implements MyUsbBroadcastReceiverFlutterApi {
  final StreamController<UsbAccessory> accessoryAttachedController;
  final StreamController<UsbAccessory> accessoryDetachedController;
  final StreamController<(UsbAccessory, bool)>
      accessoryPermissionReceivedController;
  final StreamController<UsbDevice> deviceAttachedController;
  final StreamController<UsbDevice> deviceDetachedController;
  final StreamController<(UsbDevice, bool)> devicePermissionReceivedController;

  MyUsbBroadcastReceiverApi()
      : accessoryAttachedController = StreamController.broadcast(),
        accessoryDetachedController = StreamController.broadcast(),
        accessoryPermissionReceivedController = StreamController.broadcast(),
        deviceAttachedController = StreamController.broadcast(),
        deviceDetachedController = StreamController.broadcast(),
        devicePermissionReceivedController = StreamController.broadcast();

  Stream<UsbAccessory> get accessoryAttached =>
      accessoryAttachedController.stream;
  Stream<UsbAccessory> get accessoryDetached =>
      accessoryDetachedController.stream;
  Stream<(UsbAccessory, bool)> get accessoryPermissionReceived =>
      accessoryPermissionReceivedController.stream;
  Stream<UsbDevice> get deviceAttached => deviceAttachedController.stream;
  Stream<UsbDevice> get deviceDetached => deviceDetachedController.stream;
  Stream<(UsbDevice, bool)> get devicePermissionReceived =>
      devicePermissionReceivedController.stream;

  @override
  void onAccessoryAttached(int hashCode) {
    final usbAccessory = MyUsbAccessory(hashCode);
    accessoryAttachedController.add(usbAccessory);
  }

  @override
  void onAccessoryDetached(int hashCode) {
    final usbAccessory = MyUsbAccessory(hashCode);
    accessoryDetachedController.add(usbAccessory);
  }

  @override
  void onAccessoryPermissionReceived(int hashCode, bool isGranted) {
    final usbAccessory = MyUsbAccessory(hashCode);
    final item = (usbAccessory, isGranted);
    accessoryPermissionReceivedController.add(item);
  }

  @override
  void onDeviceAttached(int hashCode) {
    final usbDevice = MyUsbDevice(hashCode);
    deviceAttachedController.add(usbDevice);
  }

  @override
  void onDeviceDetached(int hashCode) {
    final usbDevice = MyUsbDevice(hashCode);
    deviceDetachedController.add(usbDevice);
  }

  @override
  void onDevicePermissionReceived(int hashCode, bool isGranted) {
    final usbDevice = MyUsbDevice(hashCode);
    final item = (usbDevice, isGranted);
    devicePermissionReceivedController.add(item);
  }
}
