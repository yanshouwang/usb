package dev.yanshouwang.usb_android

import android.hardware.usb.UsbInterface

class MyUsbInterface(private val collector: MyCollector) : MyUsbInterfaceHostApi {
    override fun getId(hashCode: Long): Long {
        val usbInterface = collector.instanceOf(hashCode) as UsbInterface
        return usbInterface.id.toLong()
    }

    override fun getAlternateSetting(hashCode: Long): Long {
        val usbInterface = collector.instanceOf(hashCode) as UsbInterface
        return usbInterface.alternateSetting.toLong()
    }

    override fun getInterfaceClass(hashCode: Long): Long {
        val usbInterface = collector.instanceOf(hashCode) as UsbInterface
        return usbInterface.interfaceClass.toLong()
    }

    override fun getInterfaceSubclass(hashCode: Long): Long {
        val usbInterface = collector.instanceOf(hashCode) as UsbInterface
        return usbInterface.interfaceSubclass.toLong()
    }

    override fun getInterfaceProtocol(hashCode: Long): Long {
        val usbInterface = collector.instanceOf(hashCode) as UsbInterface
        return usbInterface.interfaceProtocol.toLong()
    }

    override fun getName(hashCode: Long): String? {
        val usbInterface = collector.instanceOf(hashCode) as UsbInterface
        return usbInterface.name
    }

    override fun getEndpointCount(hashCode: Long): Long {
        val usbInterface = collector.instanceOf(hashCode) as UsbInterface
        return usbInterface.endpointCount.toLong()
    }
}