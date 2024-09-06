abstract interface class USBAccessory {
  Future<String> getManufacturer();
  Future<String> getModel();
  Future<String?> getDescription();
  Future<String?> getVersion();
  Future<String?> getUri();
  Future<String?> getSerial();
}
