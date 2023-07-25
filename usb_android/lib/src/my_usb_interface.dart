import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';

final myUsbInterfaceApi = MyUsbInterfaceHostApi();

class MyUsbInterface extends MyObject implements UsbInterface {
  MyUsbInterface(super.hashCode);

  @override
  Future<int> getAlternateSetting() {
    return myUsbInterfaceApi.getAlternateSetting(hashCode);
  }

  @override
  Future<int> getEndpointCount() {
    return myUsbInterfaceApi.getEndpointCount(hashCode);
  }

  @override
  Future<int> getId() {
    return myUsbInterfaceApi.getId(hashCode);
  }

  @override
  Future<int> getInterfaceClass() {
    return myUsbInterfaceApi.getInterfaceClass(hashCode);
  }

  @override
  Future<int> getInterfaceProtocol() {
    return myUsbInterfaceApi.getInterfaceProtocol(hashCode);
  }

  @override
  Future<int> getInterfaceSubclass() {
    return myUsbInterfaceApi.getInterfaceSubclass(hashCode);
  }

  @override
  Future<String?> getName() {
    return myUsbInterfaceApi.getName(hashCode);
  }
}
