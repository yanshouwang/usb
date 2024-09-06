import 'usb_interface.dart';

abstract interface class USBConfiguration {
  Future<int> getId();
  Future<String?> getName();
  Future<int> getMaxPower();
  Future<int> getInterfaceCount();
  Future<bool> getIsRemoteWakeup();
  Future<bool> getIsSelfPowered();
  Future<USBInterface> getInterface(int index);
}
