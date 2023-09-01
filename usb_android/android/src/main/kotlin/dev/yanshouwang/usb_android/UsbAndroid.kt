package dev.yanshouwang.usb_android

import android.content.IntentFilter
import android.hardware.usb.UsbManager
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** UsbPlugin */
class UsbAndroid : FlutterPlugin {
    private lateinit var myCollector: MyCollector
    private lateinit var myUsbManager: MyUsbManager
    private lateinit var myUsbAccessory: MyUsbAccessory
    private lateinit var myUsbDevice: MyUsbDevice
    private lateinit var myUsbConfiguration: MyUsbConfiguration
    private lateinit var myUsbInterface: MyUsbInterface
    private lateinit var myUsbBroadcastReceiver: MyUsbBroadcastReceiver

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val context = binding.applicationContext
        val binaryMessenger = binding.binaryMessenger
        val filter = IntentFilter().apply {
            this.addAction(UsbManager.ACTION_USB_ACCESSORY_ATTACHED)
            this.addAction(UsbManager.ACTION_USB_ACCESSORY_DETACHED)
            this.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED)
            this.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED)
            this.addAction(MyUsbManager.ACTION_USB_ACCESSORY_PERMISSION)
            this.addAction(MyUsbManager.ACTION_USB_DEVICE_PERMISSION)
        }
        myCollector = MyCollector()
        myUsbManager = MyUsbManager(context, myCollector)
        myUsbAccessory = MyUsbAccessory(myCollector)
        myUsbDevice = MyUsbDevice(myCollector)
        myUsbConfiguration = MyUsbConfiguration(myCollector)
        myUsbInterface = MyUsbInterface(myCollector)
        myUsbBroadcastReceiver = MyUsbBroadcastReceiver(binaryMessenger, myCollector)
        MyCollectorHostApi.setUp(binaryMessenger, myCollector)
        MyUsbManagerHostApi.setUp(binaryMessenger, myUsbManager)
        MyUsbAccessoryHostApi.setUp(binaryMessenger, myUsbAccessory)
        MyUsbDeviceHostApi.setUp(binaryMessenger, myUsbDevice)
        MyUsbConfigurationHostApi.setUp(binaryMessenger, myUsbConfiguration)
        MyUsbInterfaceHostApi.setUp(binaryMessenger, myUsbInterface)
        ContextCompat.registerReceiver(context, myUsbBroadcastReceiver, filter, ContextCompat.RECEIVER_EXPORTED)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val context = binding.applicationContext
        val binaryMessenger = binding.binaryMessenger
        MyCollectorHostApi.setUp(binaryMessenger, null)
        MyUsbManagerHostApi.setUp(binaryMessenger, null)
        MyUsbAccessoryHostApi.setUp(binaryMessenger, null)
        MyUsbDeviceHostApi.setUp(binaryMessenger, null)
        MyUsbConfigurationHostApi.setUp(binaryMessenger, null)
        MyUsbInterfaceHostApi.setUp(binaryMessenger, null)
        context.unregisterReceiver(myUsbBroadcastReceiver)
    }
}
