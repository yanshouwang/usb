package dev.yanshouwang.usb_android

import android.hardware.usb.UsbConfiguration

class USBConfigurationAPI : USBConfigurationHostAPI {
    override fun getId(hashCode: Long): Long {
        val configuration = InstanceManager.instanceOf(hashCode) as UsbConfiguration
        return configuration.id.toLong()
    }

    override fun getName(hashCode: Long): String? {
        val configuration = InstanceManager.instanceOf(hashCode) as UsbConfiguration
        return configuration.name
    }

    override fun getMaxPower(hashCode: Long): Long {
        val configuration = InstanceManager.instanceOf(hashCode) as UsbConfiguration
        return configuration.maxPower.toLong()
    }

    override fun getInterfaceCount(hashCode: Long): Long {
        val configuration = InstanceManager.instanceOf(hashCode) as UsbConfiguration
        return configuration.interfaceCount.toLong()
    }

    override fun getIsRemoteWakeup(hashCode: Long): Boolean {
        val configuration = InstanceManager.instanceOf(hashCode) as UsbConfiguration
        return configuration.isRemoteWakeup
    }

    override fun getIsSelfPowered(hashCode: Long): Boolean {
        val configuration = InstanceManager.instanceOf(hashCode) as UsbConfiguration
        return configuration.isSelfPowered
    }

    override fun getInterface(hashCode: Long, index: Long): Long {
        val configuration = InstanceManager.instanceOf(hashCode) as UsbConfiguration
        val `interface` = configuration.getInterface(index.toInt())
        InstanceManager.allocate(configuration)
        return `interface`.hashCode().toLong()
    }
}