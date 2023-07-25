import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_api.dart';
import 'my_object.dart';
import 'my_usb_interface.dart';

final myUsbConfigurationApi = MyUsbConfigurationHostApi();

class MyUsbConfiguration extends MyObject implements UsbConfiguration {
  MyUsbConfiguration(super.hashCode);

  @override
  Future<int> getId() {
    return myUsbConfigurationApi.getId(hashCode);
  }

  @override
  Future<UsbInterface> getInterface(int index) async {
    final usbInterfaceHashCode =
        await myUsbConfigurationApi.getInterface(hashCode, index);
    return MyUsbInterface(usbInterfaceHashCode);
  }

  @override
  Future<int> getInterfaceCount() {
    return myUsbConfigurationApi.getInterfaceCount(hashCode);
  }

  @override
  Future<bool> getIsRemoteWakeup() {
    return myUsbConfigurationApi.getIsRemoteWakeup(hashCode);
  }

  @override
  Future<bool> getIsSelfPowered() {
    return myUsbConfigurationApi.getIsSelfPowered(hashCode);
  }

  @override
  Future<int> getMaxPower() {
    return myUsbConfigurationApi.getMaxPower(hashCode);
  }

  @override
  Future<String?> getName() {
    return myUsbConfigurationApi.getName(hashCode);
  }
}
