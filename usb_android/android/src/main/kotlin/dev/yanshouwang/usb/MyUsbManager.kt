package dev.yanshouwang.usb

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbAccessory
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import androidx.core.content.ContextCompat

class MyUsbManager(private val context: Context, private val collector: MyCollector) :
    MyUsbManagerHostApi {
    companion object {
        const val ACTION_USB_ACCESSORY_PERMISSION = "dev.yanshouwang.USB_ACCESSORY_PERMISSION"
        const val ACTION_USB_DEVICE_PERMISSION = "dev.yanshouwang.USB_DEVICE_PERMISSION"
    }

    private val usbManager =
        ContextCompat.getSystemService(context, UsbManager::class.java) as UsbManager

    override fun getAccessories(): List<Long> {
        return usbManager.accessoryList.map { accessory ->
            collector.allocate(accessory)
            return@map accessory.hashCode().toLong()
        }
    }

    override fun getDevices(): Map<String, Long> {
        return usbManager.deviceList.mapValues { entry ->
            val device = entry.value
            collector.allocate(device)
            return@mapValues device.hashCode().toLong()
        }
    }

    override fun hasAccessoryPermission(accessoryHashCode: Long): Boolean {
        val accessory = collector.instanceOf(accessoryHashCode) as UsbAccessory
        return usbManager.hasPermission(accessory)
    }

    override fun hasDevicePermission(deviceHashCode: Long): Boolean {
        val device = collector.instanceOf(deviceHashCode) as UsbDevice
        return usbManager.hasPermission(device)
    }

    override fun requestAccessoryPermission(accessoryHashCode: Long) {
        val accessory = collector.instanceOf(accessoryHashCode) as UsbAccessory
        val intent = Intent(ACTION_USB_ACCESSORY_PERMISSION)
        val pi = PendingIntent.getBroadcast(context, 0, intent, 0)
        return usbManager.requestPermission(accessory, pi)
    }

    override fun requestDevicePermission(deviceHashCode: Long) {
        val device = collector.instanceOf(deviceHashCode) as UsbDevice
        val intent = Intent(ACTION_USB_DEVICE_PERMISSION)
        val pi = PendingIntent.getBroadcast(context, 0, intent, 0)
        return usbManager.requestPermission(device, pi)
    }
}