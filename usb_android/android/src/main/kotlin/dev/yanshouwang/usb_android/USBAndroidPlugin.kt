package dev.yanshouwang.usb_android

import android.content.IntentFilter
import android.hardware.usb.UsbManager
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** USBAndroidPlugin */
class USBAndroidPlugin : FlutterPlugin {
    private lateinit var receiver: USBBroadcastReceiver

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val context = binding.applicationContext
        val binaryMessenger = binding.binaryMessenger

        val finalizerAPI = FinalizerAPI()
        val managerAPI = USBManagerAPI(context)
        val accessoryAPI = USBAccessoryAPI()
        val deviceAPI = USBDeviceAPI()
        val configurationAPI = USBConfigurationAPI()
        val interfaceAPI = USBInterfaceAPI()
        val deviceConnectionAPI = USBDeviceConnectionAPI()

        FinalizerHostAPI.setUp(binaryMessenger, finalizerAPI)
        USBManagerHostAPI.setUp(binaryMessenger, managerAPI)
        USBAccessoryHostAPI.setUp(binaryMessenger, accessoryAPI)
        USBDeviceHostAPI.setUp(binaryMessenger, deviceAPI)
        USBConfigurationHostAPI.setUp(binaryMessenger, configurationAPI)
        USBInterfaceHostAPI.setUp(binaryMessenger, interfaceAPI)
        USBDeviceConnectionHostAPI.setUp(binaryMessenger, deviceConnectionAPI)

        receiver = USBBroadcastReceiver(binaryMessenger)
        val filter = IntentFilter().apply {
            this.addAction(UsbManager.ACTION_USB_ACCESSORY_ATTACHED)
            this.addAction(UsbManager.ACTION_USB_ACCESSORY_DETACHED)
            this.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED)
            this.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED)
            this.addAction(USBManagerAPI.ACTION_USB_ACCESSORY_PERMISSION)
            this.addAction(USBManagerAPI.ACTION_USB_DEVICE_PERMISSION)
        }
        ContextCompat.registerReceiver(context, receiver, filter, ContextCompat.RECEIVER_NOT_EXPORTED)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val context = binding.applicationContext
        val binaryMessenger = binding.binaryMessenger

        FinalizerHostAPI.setUp(binaryMessenger, null)
        USBManagerHostAPI.setUp(binaryMessenger, null)
        USBAccessoryHostAPI.setUp(binaryMessenger, null)
        USBDeviceHostAPI.setUp(binaryMessenger, null)
        USBConfigurationHostAPI.setUp(binaryMessenger, null)
        USBInterfaceHostAPI.setUp(binaryMessenger, null)
        USBDeviceConnectionHostAPI.setUp(binaryMessenger, null)

        context.unregisterReceiver(receiver)
    }
}
