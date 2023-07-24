abstract class UsbInterface {
  Future<int> getId();
  Future<int> getAlternateSetting();
  Future<int> getInterfaceClass();
  Future<int> getInterfaceSubclass();
  Future<int> getInterfaceProtocol();
  Future<String?> getName();
  Future<int> getEndpointCount();
}
