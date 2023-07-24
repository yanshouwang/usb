import 'usb_configuration.dart';
import 'usb_interface.dart';

abstract class UsbDevice {
  Future<int> getDeviceClass();
  Future<int> getDeviceSubClass();
  Future<int> getDeviceProtocol();
  Future<String> getDeviceName();
  Future<int> getVendorId();
  Future<int> getProductId();
  Future<String?> getManufacturerName();
  Future<String?> getProductName();
  Future<int> getConfigurationCount();
  Future<int> getInterfaceCount();
  Future<String> getVersion();
  Future<String?> getSerialNumber();
  Future<UsbConfiguration> getConfiguration(int index);
  Future<UsbInterface> getInterface(int index);
}
