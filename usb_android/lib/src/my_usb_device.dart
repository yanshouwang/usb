import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';
import 'my_usb_configuration.dart';
import 'my_usb_interface.dart';

final myUsbDeviceApi = MyUsbDeviceHostApi();

class MyUsbDevice extends MyObject implements UsbDevice {
  MyUsbDevice(super.myHashCode);

  @override
  Future<UsbConfiguration> getConfiguration(int index) async {
    final id = await myUsbDeviceApi.getConfiguration(myHashCode, index);
    return MyUsbConfiguration(id);
  }

  @override
  Future<int> getConfigurationCount() {
    return myUsbDeviceApi.getConfigurationCount(myHashCode);
  }

  @override
  Future<int> getDeviceClass() {
    return myUsbDeviceApi.getDeviceClass(myHashCode);
  }

  @override
  Future<String> getDeviceName() {
    return myUsbDeviceApi.getDeviceName(myHashCode);
  }

  @override
  Future<int> getDeviceProtocol() {
    return myUsbDeviceApi.getDeviceProtocol(myHashCode);
  }

  @override
  Future<int> getDeviceSubClass() {
    return myUsbDeviceApi.getDeviceSubClass(myHashCode);
  }

  @override
  Future<UsbInterface> getInterface(int index) async {
    final id = await myUsbDeviceApi.getInterface(myHashCode, index);
    return MyUsbInterface(id);
  }

  @override
  Future<int> getInterfaceCount() {
    return myUsbDeviceApi.getInterfaceCount(myHashCode);
  }

  @override
  Future<String?> getManufacturerName() {
    return myUsbDeviceApi.getManufacturerName(myHashCode);
  }

  @override
  Future<int> getProductId() {
    return myUsbDeviceApi.getProductId(myHashCode);
  }

  @override
  Future<String?> getProductName() {
    return myUsbDeviceApi.getProductName(myHashCode);
  }

  @override
  Future<String?> getSerialNumber() {
    return myUsbDeviceApi.getSerialNumber(myHashCode);
  }

  @override
  Future<int> getVendorId() {
    return myUsbDeviceApi.getVendorId(myHashCode);
  }

  @override
  Future<String> getVersion() {
    return myUsbDeviceApi.getVersion(myHashCode);
  }
}
