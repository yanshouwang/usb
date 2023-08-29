import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/my_api.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/src/main/kotlin/dev/yanshouwang/usb_android/MyApi.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.yanshouwang.usb_android',
    ),
  ),
)
@HostApi()
abstract class MyCollectorHostApi {
  void free(int hashCode);
}

/// This class allows you to access the state of USB and communicate with USB devices. Currently only host mode is
/// supported in the public API.
@HostApi()
abstract class MyUsbManagerHostApi {
  /// Returns a list of currently attached USB accessories. (in the current implementation there can be at most one)
  ///
  /// Requires the PackageManager#FEATURE_USB_ACCESSORY feature which can be detected using
  /// PackageManager.hasSystemFeature(String).
  List<int> getAccessories();

  /// Returns a HashMap containing all USB devices currently attached. USB device name is the key for the returned
  /// HashMap. The result will be empty if no devices are attached, or if USB host mode is inactive or unsupported.
  ///
  /// Requires the PackageManager#FEATURE_USB_HOST feature which can be detected using
  /// PackageManager.hasSystemFeature(String).
  Map<String, int> getDevices();

  /// Returns true if the caller has permission to access the accessory. Permission might have been granted temporarily via
  /// requestPermission(android.hardware.usb.UsbAccessory, android.app.PendingIntent) or by the user
  /// choosing the caller as the default application for the accessory.
  ///
  /// Requires the PackageManager#FEATURE_USB_ACCESSORY feature which can be detected using
  /// PackageManager.hasSystemFeature(String).
  bool hasAccessoryPermission(int hashCode);
  void requestAccessoryPermission(int hashCode);

  /// Returns true if the caller has permission to access the device. Permission might have been granted temporarily via
  /// requestPermission(android.hardware.usb.UsbDevice, android.app.PendingIntent) or by the user
  /// choosing the caller as the default application for the device. Permission for USB devices of class
  /// UsbConstants#USB_CLASS_VIDEO for clients that target SDK Build.VERSION_CODES.P and above can be granted
  /// only if they have additionally the Manifest.permission.CAMERA permission.
  ///
  /// Requires the PackageManager#FEATURE_USB_HOST feature which can be detected using
  /// PackageManager.hasSystemFeature(String).
  bool hasDevicePermission(int hashCode);
  void requestDevicePermission(int hashCode);
}

@FlutterApi()
abstract class MyUsbBroadcastReceiverFlutterApi {
  void onAccessoryAttached(int hashCode);
  void onAccessoryDetached(int hashCode);
  void onAccessoryPermissionReceived(int hashCode, bool isGranted);
  void onDeviceAttached(int hashCode);
  void onDeviceDetached(int hashCode);
  void onDevicePermissionReceived(int hashCode, bool isGranted);
}

/// A class representing a USB accessory, which is an external hardware component that communicates with an android
/// application over USB. The accessory is the USB host and android the device side of the USB connection.
@HostApi()
abstract class MyUsbAccessoryHostApi {
  String getManufacturer(int hashCode);
  String getModel(int hashCode);
  String? getDescription(int hashCode);
  String? getVersion(int hashCode);
  String? getUri(int hashCode);
  String? getSerial(int hashCode);
}

/// This class represents a USB device attached to the android device with the android device acting as the USB host. Each
/// device contains one or more UsbInterfaces, each of which contains a number of UsbEndpoints (the channels via
/// which data is transmitted over USB).
///
/// This class contains information (along with UsbInterface and UsbEndpoint) that describes the capabilities of the
/// USB device. To communicate with the device, you open a UsbDeviceConnection for the device and use UsbRequest
/// to send and receive data on an endpoint. UsbDeviceConnection#controlTransfer is used for control requests on
/// endpoint zero.
@HostApi()
abstract class MyUsbDeviceHostApi {
  int getDeviceClass(int hashCode);
  int getDeviceSubClass(int hashCode);
  int getDeviceProtocol(int hashCode);
  String getDeviceName(int hashCode);
  int getVendorId(int hashCode);
  int getProductId(int hashCode);
  String? getManufacturerName(int hashCode);
  String? getProductName(int hashCode);
  int getConfigurationCount(int hashCode);
  int getInterfaceCount(int hashCode);
  String getVersion(int hashCode);
  String? getSerialNumber(int hashCode);

  /// Returns the UsbConfiguration at the given index.
  int getConfiguration(int hashCode, int index);

  /// Returns the UsbInterface at the given index. For devices with multiple configurations, you will probably want to use
  /// UsbConfiguration#getInterface instead.
  int getInterface(int hashCode, int index);
}

/// A class representing a configuration on a UsbDevice. A USB configuration can have one or more interfaces, each one
/// providing a different piece of functionality, separate from the other interfaces. An interface will have one or more
/// UsbEndpoints, which are the channels by which the host transfers data with the device.
@HostApi()
abstract class MyUsbConfigurationHostApi {
  int getId(int hashCode);
  String? getName(int hashCode);
  int getMaxPower(int hashCode);
  int getInterfaceCount(int hashCode);
  bool getIsRemoteWakeup(int hashCode);
  bool getIsSelfPowered(int hashCode);

  /// Returns the UsbInterface at the given index.
  int getInterface(int hashCode, int index);
}

@HostApi()
abstract class MyUsbInterfaceHostApi {
  int getId(int hashCode);
  int getAlternateSetting(int hashCode);
  int getInterfaceClass(int hashCode);
  int getInterfaceSubclass(int hashCode);
  int getInterfaceProtocol(int hashCode);
  String? getName(int hashCode);
  int getEndpointCount(int hashCode);
}
