abstract interface class USBDeviceConnection {
  Future<int> getFileDescriptor();
  Future<void> close();
}
