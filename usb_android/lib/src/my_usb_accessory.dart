import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';

final myUsbAccessoryApi = MyUsbAccessoryHostApi();

class MyUsbAccessory extends MyObject implements UsbAccessory {
  MyUsbAccessory(super.hashCode);

  @override
  Future<String?> getDescription() {
    return myUsbAccessoryApi.getDescription(hashCode);
  }

  @override
  Future<String> getManufacturer() {
    return myUsbAccessoryApi.getManufacturer(hashCode);
  }

  @override
  Future<String> getModel() {
    return myUsbAccessoryApi.getModel(hashCode);
  }

  @override
  Future<String?> getSerial() {
    return myUsbAccessoryApi.getSerial(hashCode);
  }

  @override
  Future<String?> getUri() {
    return myUsbAccessoryApi.getUri(hashCode);
  }

  @override
  Future<String?> getVersion() {
    return myUsbAccessoryApi.getVersion(hashCode);
  }
}
