package dev.yanshouwang.usb

import android.hardware.usb.UsbDevice

class MyUsbDevice(private val collector: MyCollector) : MyUsbDeviceHostApi {
    override fun getDeviceClass(hashCode: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.deviceClass.toLong()
    }

    override fun getDeviceSubClass(hashCode: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.deviceSubclass.toLong()
    }

    override fun getDeviceProtocol(hashCode: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.deviceProtocol.toLong()
    }

    override fun getDeviceName(hashCode: Long): String {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.deviceName
    }

    override fun getVendorId(hashCode: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.vendorId.toLong()
    }

    override fun getProductId(hashCode: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.productId.toLong()
    }

    override fun getManufacturerName(hashCode: Long): String? {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.manufacturerName
    }

    override fun getProductName(hashCode: Long): String? {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.productName
    }

    override fun getConfigurationCount(hashCode: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.configurationCount.toLong()
    }

    override fun getInterfaceCount(hashCode: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.interfaceCount.toLong()
    }

    override fun getVersion(hashCode: Long): String {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.version
    }

    override fun getSerialNumber(hashCode: Long): String? {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        return usbDevice.serialNumber
    }

    override fun getConfiguration(hashCode: Long, index: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        val usbConfiguration = usbDevice.getConfiguration(index.toInt())
        collector.allocate(usbConfiguration)
        return usbConfiguration.hashCode().toLong()
    }

    override fun getInterface(hashCode: Long, index: Long): Long {
        val usbDevice = collector.instanceOf(hashCode) as UsbDevice
        val usbInterface = usbDevice.getInterface(index.toInt())
        collector.allocate(usbInterface)
        return usbInterface.hashCode().toLong()
    }
}