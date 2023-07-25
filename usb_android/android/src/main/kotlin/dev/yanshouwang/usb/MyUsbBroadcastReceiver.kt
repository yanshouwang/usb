package dev.yanshouwang.usb

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbAccessory
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import io.flutter.plugin.common.BinaryMessenger

class MyUsbBroadcastReceiver(
    binaryMessenger: BinaryMessenger, private val collector: MyCollector
) : BroadcastReceiver() {
    private val api = MyUsbBroadcastReceiverFlutterApi(binaryMessenger)

    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            UsbManager.ACTION_USB_ACCESSORY_ATTACHED -> {
                val usbAccessory =
                    intent.getParcelableExtra<UsbAccessory>(UsbManager.EXTRA_ACCESSORY) ?: return
                collector.allocate(usbAccessory)
                api.onAccessoryAttached(usbAccessory.hashCode().toLong()) {}
            }

            UsbManager.ACTION_USB_ACCESSORY_DETACHED -> {
                val usbAccessory =
                    intent.getParcelableExtra<UsbAccessory>(UsbManager.EXTRA_ACCESSORY) ?: return
                collector.allocate(usbAccessory)
                api.onAccessoryDetached(usbAccessory.hashCode().toLong()) {}
            }

            MyUsbManager.ACTION_USB_ACCESSORY_PERMISSION -> {
                val usbAccessory =
                    intent.getParcelableExtra<UsbAccessory>(UsbManager.EXTRA_ACCESSORY) ?: return
                val isGranted = intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)
                collector.allocate(usbAccessory)
                api.onAccessoryPermissionReceived(usbAccessory.hashCode().toLong(), isGranted) {}
            }

            UsbManager.ACTION_USB_DEVICE_ATTACHED -> {
                val usbDevice =
                    intent.getParcelableExtra<UsbDevice>(UsbManager.EXTRA_DEVICE) ?: return
                collector.allocate(usbDevice)
                api.onDeviceAttached(usbDevice.hashCode().toLong()) {}
            }

            UsbManager.ACTION_USB_DEVICE_DETACHED -> {
                val usbDevice =
                    intent.getParcelableExtra<UsbDevice>(UsbManager.EXTRA_DEVICE) ?: return
                collector.allocate(usbDevice)
                api.onDeviceDetached(usbDevice.hashCode().toLong()) {}
            }

            MyUsbManager.ACTION_USB_DEVICE_PERMISSION -> {
                val usbDevice =
                    intent.getParcelableExtra<UsbDevice>(UsbManager.EXTRA_DEVICE) ?: return
                val isGranted = intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)
                collector.allocate(usbDevice)
                api.onDevicePermissionReceived(usbDevice.hashCode().toLong(), isGranted) {}
            }

            else -> {}
        }
    }
}