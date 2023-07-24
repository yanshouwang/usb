import 'dart:async';

import 'my_api.dart';

final myUsbBroadcastReceiverApi = MyUsbBroadcastReceiverApi();

class MyUsbBroadcastReceiverApi implements MyUsbBroadcastReceiverFlutterApi {
  final StreamController<int> accessoryAttachedController;
  final StreamController<int> accessoryDetachedController;
  final StreamController<(int, bool)> accessoryPermissionReceivedController;
  final StreamController<int> deviceAttachedController;
  final StreamController<int> deviceDetachedController;
  final StreamController<(int, bool)> devicePermissionReceivedController;

  MyUsbBroadcastReceiverApi()
      : accessoryAttachedController = StreamController.broadcast(),
        accessoryDetachedController = StreamController.broadcast(),
        accessoryPermissionReceivedController = StreamController.broadcast(),
        deviceAttachedController = StreamController.broadcast(),
        deviceDetachedController = StreamController.broadcast(),
        devicePermissionReceivedController = StreamController.broadcast();

  Stream<int> get accessoryAttached => accessoryAttachedController.stream;
  Stream<int> get accessoryDetached => accessoryDetachedController.stream;
  Stream<(int, bool)> get accessoryPermissionReceived =>
      accessoryPermissionReceivedController.stream;
  Stream<int> get deviceAttached => deviceAttachedController.stream;
  Stream<int> get deviceDetached => deviceDetachedController.stream;
  Stream<(int, bool)> get devicePermissionReceived =>
      devicePermissionReceivedController.stream;

  @override
  void onAccessoryAttached(int hashCode) {
    accessoryAttachedController.add(hashCode);
  }

  @override
  void onAccessoryDetached(int hashCode) {
    accessoryDetachedController.add(hashCode);
  }

  @override
  void onAccessoryPermissionReceived(int hashCode, bool isGranted) {
    final item = (hashCode, isGranted);
    accessoryPermissionReceivedController.add(item);
  }

  @override
  void onDeviceAttached(int hashCode) {
    deviceAttachedController.add(hashCode);
  }

  @override
  void onDeviceDetached(int hashCode) {
    deviceDetachedController.add(hashCode);
  }

  @override
  void onDevicePermissionReceived(int hashCode, bool isGranted) {
    final item = (hashCode, isGranted);
    devicePermissionReceivedController.add(item);
  }
}
