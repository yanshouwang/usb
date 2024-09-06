/// Contains constants for the USB protocol. These constants correspond to definitions in linux/usb/ch9.h in
/// the linux kernel.
abstract final class USBConstants {
  /// Bitmask used for encoding the request type for a control request on endpoint zero.
  static const usbTypeMask = (0x03 << 5);

  /// Used to specify that an endpoint zero control request is a standard request.
  static const usbTypeStandard = (0x00 << 5);

  /// Used to specify that an endpoint zero control request is a class specific request.
  static const usbTypeClass = (0x01 << 5);

  /// Used to specify that an endpoint zero control request is a vendor specific request.
  static const usbTypeVendor = (0x02 << 5);

  /// Reserved endpoint zero control request type (currently unused).
  static const usbTypeReserved = (0x03 << 5);

  /// USB class indicating that the class is determined on a per-interface basis.
  static const usbClassPerInterface = 0;

  /// USB class for audio devices.
  static const usbClassAudio = 1;

  /// USB class for communication devices.
  static const usbClassComm = 2;

  /// USB class for human interface devices (for example, mice and keyboards).
  static const usbClassHID = 3;

  /// USB class for physical devices.
  static const usbClassPhysical = 5;

  /// USB class for still image devices (digital cameras).
  static const usbClassStillImage = 6;

  /// USB class for printers.
  static const usbClassPrinter = 7;

  /// USB class for mass storage devices.
  static const usbClassMassStorage = 8;

  /// USB class for USB hubs.
  static const usbClassHub = 9;

  /// USB class for CDC devices (communications device class).
  static const usbClassCDCData = 0x0a;

  /// USB class for content smart card devices.
  static const usbClassCSCID = 0x0b;

  /// USB class for content security devices.
  static const usbClassContentSec = 0x0d;

  /// USB class for video devices.
  static const usbClassVideo = 0x0e;

  /// USB class for wireless controller devices.
  static const usbClassWirelessController = 0xe0;

  /// USB class for wireless miscellaneous devices.
  static const usbClassMisc = 0xef;

  /// Application specific USB class.
  static const usbClassAppSpec = 0xfe;

  /// Vendor specific USB class.
  static const usbClassVendorSpec = 0xff;

  /// Boot subclass for HID devices.
  static const usbInterfaceSubclassRoot = 1;

  /// Vendor specific USB subclass.
  static const usbSubclassVendorSpec = 0xff;
}
