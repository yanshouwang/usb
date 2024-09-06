package dev.yanshouwang.usb_android

import android.hardware.usb.UsbDeviceConnection

class USBDeviceConnectionAPI : USBDeviceConnectionHostAPI {
    override fun getFileDescriptor(hashCode: Long): Long {
        val connection = InstanceManager.instanceOf(hashCode) as UsbDeviceConnection
        return connection.fileDescriptor.toLong()
    }

    override fun close(hashCode: Long) {
        val connection = InstanceManager.instanceOf(hashCode) as UsbDeviceConnection
        connection.close()
    }
}