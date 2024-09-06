package dev.yanshouwang.usb_android

import android.hardware.usb.UsbInterface

class USBInterfaceAPI : USBInterfaceHostAPI {
    override fun getId(hashCode: Long): Long {
        val `interface` = InstanceManager.instanceOf(hashCode) as UsbInterface
        return `interface`.id.toLong()
    }

    override fun getAlternateSetting(hashCode: Long): Long {
        val `interface` = InstanceManager.instanceOf(hashCode) as UsbInterface
        return `interface`.alternateSetting.toLong()
    }

    override fun getInterfaceClass(hashCode: Long): Long {
        val `interface` = InstanceManager.instanceOf(hashCode) as UsbInterface
        return `interface`.interfaceClass.toLong()
    }

    override fun getInterfaceSubclass(hashCode: Long): Long {
        val `interface` = InstanceManager.instanceOf(hashCode) as UsbInterface
        return `interface`.interfaceSubclass.toLong()
    }

    override fun getInterfaceProtocol(hashCode: Long): Long {
        val `interface` = InstanceManager.instanceOf(hashCode) as UsbInterface
        return `interface`.interfaceProtocol.toLong()
    }

    override fun getName(hashCode: Long): String? {
        val `interface` = InstanceManager.instanceOf(hashCode) as UsbInterface
        return `interface`.name
    }

    override fun getEndpointCount(hashCode: Long): Long {
        val `interface` = InstanceManager.instanceOf(hashCode) as UsbInterface
        return `interface`.endpointCount.toLong()
    }
}