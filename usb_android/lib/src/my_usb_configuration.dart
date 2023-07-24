import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';
import 'my_usb_interface.dart';

final myUsbConfigurationApi = MyUsbConfigurationHostApi();

class MyUsbConfiguration extends MyObject implements UsbConfiguration {
  MyUsbConfiguration(super.myHashCode);

  @override
  Future<int> getId() {
    return myUsbConfigurationApi.getId(myHashCode);
  }

  @override
  Future<UsbInterface> getInterface(int index) async {
    final id = await myUsbConfigurationApi.getInterface(myHashCode, index);
    return MyUsbInterface(id);
  }

  @override
  Future<int> getInterfaceCount() {
    return myUsbConfigurationApi.getInterfaceCount(myHashCode);
  }

  @override
  Future<bool> getIsRemoteWakeup() {
    return myUsbConfigurationApi.getIsRemoteWakeup(myHashCode);
  }

  @override
  Future<bool> getIsSelfPowered() {
    return myUsbConfigurationApi.getIsSelfPowered(myHashCode);
  }

  @override
  Future<int> getMaxPower() {
    return myUsbConfigurationApi.getMaxPower(myHashCode);
  }

  @override
  Future<String?> getName() {
    return myUsbConfigurationApi.getName(myHashCode);
  }
}
