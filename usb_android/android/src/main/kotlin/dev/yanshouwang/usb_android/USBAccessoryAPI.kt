package dev.yanshouwang.usb_android

import android.hardware.usb.UsbAccessory

class USBAccessoryAPI : USBAccessoryHostAPI {
    override fun getManufacturer(hashCode: Long): String {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        return accessory.manufacturer
    }

    override fun getModel(hashCode: Long): String {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        return accessory.model
    }

    override fun getDescription(hashCode: Long): String? {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        return accessory.description
    }

    override fun getVersion(hashCode: Long): String? {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        return accessory.version
    }

    override fun getUri(hashCode: Long): String? {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        return accessory.uri
    }

    override fun getSerial(hashCode: Long): String? {
        val accessory = InstanceManager.instanceOf(hashCode) as UsbAccessory
        return accessory.serial
    }
}