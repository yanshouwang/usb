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
      myUsbBroadcastReceiverApi.deviceAttached
          .map((myHashCode) => MyUsbDevice(myHashCode));
  @override
  Stream<UsbDevice> get deviceDetached =>
      myUsbBroadcastReceiverApi.deviceDetached
          .map((myHashCode) => MyUsbDevice(myHashCode));

  @override
  Future<List<UsbAccessory>> getAccessories() async {
    final myHashCodes = await myUsbManagerApi.getAccessories();
    return myHashCodes
        .cast<int>()
        .map((myHashCode) => MyUsbAccessory(myHashCode))
        .toList();
  }

  @override
  Future<Map<String, UsbDevice>> getDevices() async {
    final items = await myUsbManagerApi.getDevices();
    return items
        .cast<String, int>()
        .map((name, myHashCode) => MapEntry(name, MyUsbDevice(myHashCode)));
  }

  @override
  Future<bool> hasAccessoryPermission(UsbAccessory accessory) {
    final myHashCode = (accessory as MyUsbAccessory).myHashCode;
    return myUsbManagerApi.hasAccessoryPermission(myHashCode);
  }

  @override
  Future<bool> hasDevicePermission(UsbDevice device) {
    final myHashCode = (device as MyUsbDevice).myHashCode;
    return myUsbManagerApi.hasDevicePermission(myHashCode);
  }

  @override
  Future<void> initialize() {
    return Future.sync(() {
      MyUsbBroadcastReceiverFlutterApi.setup(myUsbBroadcastReceiverApi);
    });
  }

  @override
  Future<bool> requestAccessoryPermission(UsbAccessory accessory) async {
    final myHashCode = (accessory as MyUsbAccessory).myHashCode;
    final completer = Completer<bool>();
    final subscription =
        myUsbBroadcastReceiverApi.accessoryPermissionReceived.listen((item) {
      final (myHashCode1, isGranted) = item;
      if (myHashCode1 != myHashCode) {
        return;
      }
      completer.complete(isGranted);
    });
    try {
      await myUsbManagerApi.requestAccessoryPermission(myHashCode);
      final isGranted = await completer.future;
      return isGranted;
    } finally {
      subscription.cancel();
    }
  }

  @override
  Future<bool> requestDevicePermission(UsbDevice device) async {
    final myHashCode = (device as MyUsbDevice).myHashCode;
    final completer = Completer<bool>();
    final subscription =
        myUsbBroadcastReceiverApi.devicePermissionReceived.listen((item) {
      final (myHashCode1, isGranted) = item;
      if (myHashCode1 != myHashCode) {
        return;
      }
      completer.complete(isGranted);
    });
    try {
      await myUsbManagerApi.requestDevicePermission(myHashCode);
      final isGranted = await completer.future;
      return isGranted;
    } finally {
      subscription.cancel();
    }
  }
}
