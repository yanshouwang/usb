import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'usb_manager.dart';

abstract base class USBPlugin extends PlatformInterface {
  /// Constructs a [USBPlugin].
  USBPlugin() : super(token: _token);

  static final Object _token = Object();

  static USBPlugin? _instance;

  /// The default instance of [USBPlugin] to use.
  static USBPlugin get instance {
    final instance = _instance;
    if (instance == null) {
      throw UnsupportedError('USBPlugin is not implemented on this platform.');
    }
    return instance;
  }

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [USBPlugin] when
  /// they register themselves.
  static set instance(USBPlugin instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  USBManager createUSBManager();
}
