import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';
import 'my_usb_configuration.dart';
import 'my_usb_interface.dart';

final myUsbDeviceApi = MyUsbDeviceHostApi();

class MyUsbDevice extends MyObject implements UsbDevice {
  MyUsbDevice(super.hashCode);

  @override
  Future<UsbConfiguration> getConfiguration(int index) async {
    final usbConfigurationHashCode =
        await myUsbDeviceApi.getConfiguration(hashCode, index);
    return MyUsbConfiguration(usbConfigurationHashCode);
  }

  @override
  Future<int> getConfigurationCount() {
    return myUsbDeviceApi.getConfigurationCount(hashCode);
  }

  @override
  Future<int> getDeviceClass() {
    return myUsbDeviceApi.getDeviceClass(hashCode);
  }

  @override
  Future<String> getDeviceName() {
    return myUsbDeviceApi.getDeviceName(hashCode);
  }

  @override
  Future<int> getDeviceProtocol() {
    return myUsbDeviceApi.getDeviceProtocol(hashCode);
  }

  @override
  Future<int> getDeviceSubClass() {
    return myUsbDeviceApi.getDeviceSubClass(hashCode);
  }

  @override
  Future<UsbInterface> getInterface(int index) async {
    final usbInterfaceHashCode =
        await myUsbDeviceApi.getInterface(hashCode, index);
    return MyUsbInterface(usbInterfaceHashCode);
  }

  @override
  Future<int> getInterfaceCount() {
    return myUsbDeviceApi.getInterfaceCount(hashCode);
  }

  @override
  Future<String?> getManufacturerName() {
    return myUsbDeviceApi.getManufacturerName(hashCode);
  }

  @override
  Future<int> getProductId() {
    return myUsbDeviceApi.getProductId(hashCode);
  }

  @override
  Future<String?> getProductName() {
    return myUsbDeviceApi.getProductName(hashCode);
  }

  @override
  Future<String?> getSerialNumber() {
    return myUsbDeviceApi.getSerialNumber(hashCode);
  }

  @override
  Future<int> getVendorId() {
    return myUsbDeviceApi.getVendorId(hashCode);
  }

  @override
  Future<String> getVersion() {
    return myUsbDeviceApi.getVersion(hashCode);
  }
}
