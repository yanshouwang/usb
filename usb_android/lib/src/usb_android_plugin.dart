import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'usb_impl.dart';

final class USBAndroidPlugin extends USBPlugin {
  static void registerWith() {
    USBPlugin.instance = USBAndroidPlugin();
  }

  @override
  USBManager createUSBManager() {
    return USBManagerImpl();
  }
}
