package dev.yanshouwang.usb_android

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbAccessory
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import androidx.core.content.ContextCompat

class USBManagerAPI(private val context: Context) : USBManagerHostAPI {
    companion object {
        const val ACTION_USB_ACCESSORY_PERMISSION = "dev.yanshouwang.USB_ACCESSORY_PERMISSION"
        const val ACTION_USB_DEVICE_PERMISSION = "dev.yanshouwang.USB_DEVICE_PERMISSION"
    }

    private val manager = ContextCompat.getSystemService(context, UsbManager::class.java) as UsbManager

    override fun getAccessories(): List<Long> {
        return manager.accessoryList.map { accessory ->
            InstanceManager.allocate(accessory)
            return@map accessory.hashCode().toLong()
        }
    }

    override fun hasAccessoryPermission(hashCode: Long): Boolean {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        return manager.hasPermission(accessory)
    }

    override fun requestAccessoryPermission(hashCode: Long) {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        val intent = Intent(ACTION_USB_ACCESSORY_PERMISSION).apply {
            setPackage(context.packageName)
        }
        val pi = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_MUTABLE)
        return manager.requestPermission(accessory, pi)
    }

    override fun getDevices(): Map<String, Long> {
        return manager.deviceList.mapValues { entry ->
            val device = entry.value
            InstanceManager.allocate(device)
            return@mapValues device.hashCode().toLong()
        }
    }

    override fun hasDevicePermission(hashCode: Long): Boolean {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return manager.hasPermission(device)
    }

    override fun requestDevicePermission(hashCode: Long) {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        val intent = Intent(ACTION_USB_DEVICE_PERMISSION).apply {
            setPackage(context.packageName)
        }
        val pi = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_MUTABLE)
        return manager.requestPermission(device, pi)
    }

    override fun openDevice(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        val connection = manager.openDevice(device)
        InstanceManager.allocate(connection)
        return connection.hashCode().toLong()
    }
}