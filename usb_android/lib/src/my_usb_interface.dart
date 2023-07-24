import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';

final myUsbInterfaceApi = MyUsbInterfaceHostApi();

class MyUsbInterface extends MyObject implements UsbInterface {
  MyUsbInterface(super.myHashCode);

  @override
  Future<int> getAlternateSetting() {
    return myUsbInterfaceApi.getAlternateSetting(myHashCode);
  }

  @override
  Future<int> getEndpointCount() {
    return myUsbInterfaceApi.getEndpointCount(myHashCode);
  }

  @override
  Future<int> getId() {
    return myUsbInterfaceApi.getId(myHashCode);
  }

  @override
  Future<int> getInterfaceClass() {
    return myUsbInterfaceApi.getInterfaceClass(myHashCode);
  }

  @override
  Future<int> getInterfaceProtocol() {
    return myUsbInterfaceApi.getInterfaceProtocol(myHashCode);
  }

  @override
  Future<int> getInterfaceSubclass() {
    return myUsbInterfaceApi.getInterfaceSubclass(myHashCode);
  }

  @override
  Future<String?> getName() {
    return myUsbInterfaceApi.getName(myHashCode);
  }
}
