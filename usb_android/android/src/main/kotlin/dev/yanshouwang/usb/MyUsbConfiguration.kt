package dev.yanshouwang.usb

import android.hardware.usb.UsbConfiguration

class MyUsbConfiguration(private val collector: MyCollector) : MyUsbConfigurationHostApi {
    override fun getId(hashCode: Long): Long {
        val usbConfiguration = collector.instanceOf(hashCode) as UsbConfiguration
        return usbConfiguration.id.toLong()
    }

    override fun getName(hashCode: Long): String? {
        val usbConfiguration = collector.instanceOf(hashCode) as UsbConfiguration
        return usbConfiguration.name
    }

    override fun getMaxPower(hashCode: Long): Long {
        val usbConfiguration = collector.instanceOf(hashCode) as UsbConfiguration
        return usbConfiguration.maxPower.toLong()
    }

    override fun getInterfaceCount(hashCode: Long): Long {
        val usbConfiguration = collector.instanceOf(hashCode) as UsbConfiguration
        return usbConfiguration.interfaceCount.toLong()
    }

    override fun getIsRemoteWakeup(hashCode: Long): Boolean {
        val usbConfiguration = collector.instanceOf(hashCode) as UsbConfiguration
        return usbConfiguration.isRemoteWakeup
    }

    override fun getIsSelfPowered(hashCode: Long): Boolean {
        val usbConfiguration = collector.instanceOf(hashCode) as UsbConfiguration
        return usbConfiguration.isSelfPowered
    }

    override fun getInterface(hashCode: Long, index: Long): Long {
        val usbConfiguration = collector.instanceOf(hashCode) as UsbConfiguration
        val usbInterface = usbConfiguration.getInterface(index.toInt())
        collector.allocate(usbConfiguration)
        return usbInterface.hashCode().toLong()
    }
}