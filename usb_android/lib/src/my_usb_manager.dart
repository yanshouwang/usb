import 'dart:async';

import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_usb_accessory.dart';
import 'my_usb_broadcast_receiver.dart';
import 'my_usb_device.dart';

final myUsbManagerApi = MyUsbManagerHostApi();

class MyUsbManager extends UsbManager {
  @override
  Stream<UsbDevice> get deviceAttached =>
      myUsbBroadcastReceiverApi.deviceAttached;
  @override
  Stream<UsbDevice> get deviceDetached =>
      myUsbBroadcastReceiverApi.deviceDetached;

  @override
  Future<List<UsbAccessory>> getAccessories() async {
    final hashCodes = await myUsbManagerApi.getAccessories();
    return hashCodes
        .cast<int>()
        .map((hashCode) => MyUsbAccessory(hashCode))
        .toList();
  }

  @override
  Future<Map<String, UsbDevice>> getDevices() async {
    final items = await myUsbManagerApi.getDevices();
    return items
        .cast<String, int>()
        .map((name, hashCode) => MapEntry(name, MyUsbDevice(hashCode)));
  }

  @override
  Future<bool> hasAccessoryPermission(UsbAccessory usbAccessory) {
    return myUsbManagerApi.hasAccessoryPermission(usbAccessory.hashCode);
  }

  @override
  Future<bool> hasDevicePermission(UsbDevice usbDevice) {
    return myUsbManagerApi.hasDevicePermission(usbDevice.hashCode);
  }

  @override
  Future<void> initialize() async {
    await Future.sync(() {
      MyUsbBroadcastReceiverFlutterApi.setup(myUsbBroadcastReceiverApi);
    });
  }

  @override
  Future<bool> requestAccessoryPermission(UsbAccessory usbAccessory) async {
    final completer = Completer<bool>();
    final subscription =
        myUsbBroadcastReceiverApi.accessoryPermissionReceived.listen((item) {
      if (item.$1 != usbAccessory) {
        return;
      }
      completer.complete(item.$2);
    });
    try {
      await myUsbManagerApi.requestAccessoryPermission(usbAccessory.hashCode);
      final isGranted = await completer.future;
      return isGranted;
    } finally {
      subscription.cancel();
    }
  }

  @override
  Future<bool> requestDevicePermission(UsbDevice usbDevice) async {
    final completer = Completer<bool>();
    final subscription =
        myUsbBroadcastReceiverApi.devicePermissionReceived.listen((item) {
      if (item.$1 != usbDevice) {
        return;
      }
      completer.complete(item.$2);
    });
    try {
      await myUsbManagerApi.requestDevicePermission(usbDevice.hashCode);
      final isGranted = await completer.future;
      return isGranted;
    } finally {
      subscription.cancel();
    }
  }
}
