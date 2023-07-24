package dev.yanshouwang.usb

import android.hardware.usb.UsbAccessory

class MyUsbAccessory(private val collector: MyCollector) : MyUsbAccessoryHostApi {
    override fun getManufacturer(hashCode: Long): String {
        val usbAccessory = collector.instanceOf(hashCode) as UsbAccessory
        return usbAccessory.manufacturer
    }

    override fun getModel(hashCode: Long): String {
        val usbAccessory = collector.instanceOf(hashCode) as UsbAccessory
        return usbAccessory.model
    }

    override fun getDescription(hashCode: Long): String? {
        val usbAccessory = collector.instanceOf(hashCode) as UsbAccessory
        return usbAccessory.description
    }

    override fun getVersion(hashCode: Long): String? {
        val usbAccessory = collector.instanceOf(hashCode) as UsbAccessory
        return usbAccessory.version
    }

    override fun getUri(hashCode: Long): String? {
        val usbAccessory = collector.instanceOf(hashCode) as UsbAccessory
        return usbAccessory.uri
    }

    override fun getSerial(hashCode: Long): String? {
        val usbAccessory = collector.instanceOf(hashCode) as UsbAccessory
        return usbAccessory.serial
    }
}