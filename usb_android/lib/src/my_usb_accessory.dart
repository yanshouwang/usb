import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';

final myUsbAccessoryApi = MyUsbAccessoryHostApi();

class MyUsbAccessory extends MyObject implements UsbAccessory {
  MyUsbAccessory(super.myHashCode);

  @override
  Future<String?> getDescription() {
    return myUsbAccessoryApi.getDescription(myHashCode);
  }

  @override
  Future<String> getManufacturer() {
    return myUsbAccessoryApi.getManufacturer(myHashCode);
  }

  @override
  Future<String> getModel() {
    return myUsbAccessoryApi.getModel(myHashCode);
  }

  @override
  Future<String?> getSerial() {
    return myUsbAccessoryApi.getSerial(myHashCode);
  }

  @override
  Future<String?> getUri() {
    return myUsbAccessoryApi.getUri(myHashCode);
  }

  @override
  Future<String?> getVersion() {
    return myUsbAccessoryApi.getVersion(myHashCode);
  }
}
