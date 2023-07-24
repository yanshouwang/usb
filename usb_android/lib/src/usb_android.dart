import 'package:usb_platform_interface/usb_platform_interface.dart';

import 'my_usb_manager.dart';

class UsbAndroid {
  static void registerWith() {
    UsbManager.instance = MyUsbManager();
  }
}
