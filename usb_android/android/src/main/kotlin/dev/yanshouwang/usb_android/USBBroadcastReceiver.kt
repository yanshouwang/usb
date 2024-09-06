package dev.yanshouwang.usb_android

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbAccessory
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import android.os.Build
import io.flutter.plugin.common.BinaryMessenger

class USBBroadcastReceiver(binaryMessenger: BinaryMessenger) : BroadcastReceiver() {
    private val api = USBBroadcastReceiverFlutterAPI(binaryMessenger)

    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            UsbManager.ACTION_USB_ACCESSORY_ATTACHED -> {
                val accessory = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(UsbManager.EXTRA_ACCESSORY, UsbAccessory::class.java)
                } else {
                    intent.getParcelableExtra(UsbManager.EXTRA_ACCESSORY)
                } ?: return
                InstanceManager.allocate(accessory)
                api.onAccessoryAttached(accessory.hashCode().toLong()) {}
            }

            UsbManager.ACTION_USB_ACCESSORY_DETACHED -> {
                val accessory = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(UsbManager.EXTRA_ACCESSORY, UsbAccessory::class.java)
                } else {
                    intent.getParcelableExtra(UsbManager.EXTRA_ACCESSORY)
                } ?: return
                InstanceManager.allocate(accessory)
                api.onAccessoryDetached(accessory.hashCode().toLong()) {}
            }

            USBManagerAPI.ACTION_USB_ACCESSORY_PERMISSION -> {
                val accessory = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(UsbManager.EXTRA_ACCESSORY, UsbAccessory::class.java)
                } else {
                    intent.getParcelableExtra(UsbManager.EXTRA_ACCESSORY)
                } ?: return
                InstanceManager.allocate(accessory)
                val isGranted = intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)
                api.onAccessoryPermission(accessory.hashCode().toLong(), isGranted) {}
            }

            UsbManager.ACTION_USB_DEVICE_ATTACHED -> {
                val device = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(UsbManager.EXTRA_DEVICE, UsbDevice::class.java)
                } else {
                    intent.getParcelableExtra(UsbManager.EXTRA_DEVICE)
                } ?: return
                InstanceManager.allocate(device)
                api.onDeviceAttached(device.hashCode().toLong()) {}
            }

            UsbManager.ACTION_USB_DEVICE_DETACHED -> {
                val device = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(UsbManager.EXTRA_DEVICE, UsbDevice::class.java)
                } else {
                    intent.getParcelableExtra(UsbManager.EXTRA_DEVICE)
                } ?: return
                InstanceManager.allocate(device)
                api.onDeviceDetached(device.hashCode().toLong()) {}
            }

            USBManagerAPI.ACTION_USB_DEVICE_PERMISSION -> {
                val device = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(UsbManager.EXTRA_DEVICE, UsbDevice::class.java)
                } else {
                    intent.getParcelableExtra(UsbManager.EXTRA_DEVICE)
                } ?: return
                InstanceManager.allocate(device)
                val isGranted = intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)
                api.onDevicePermission(device.hashCode().toLong(), isGranted) {}
            }

            else -> {}
        }
    }
}