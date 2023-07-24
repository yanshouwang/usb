import 'usb_interface.dart';

abstract class UsbConfiguration {
  Future<int> getId();
  Future<String?> getName();
  Future<int> getMaxPower();
  Future<int> getInterfaceCount();
  Future<bool> getIsRemoteWakeup();
  Future<bool> getIsSelfPowered();
  Future<UsbInterface> getInterface(int index);
}
