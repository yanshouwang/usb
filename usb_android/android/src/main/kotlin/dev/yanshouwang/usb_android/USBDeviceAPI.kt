package dev.yanshouwang.usb_android

import android.hardware.usb.UsbDevice
import android.os.Build

class USBDeviceAPI : USBDeviceHostAPI {
    override fun getDeviceClass(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.deviceClass.toLong()
    }

    override fun getDeviceSubClass(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.deviceSubclass.toLong()
    }

    override fun getDeviceProtocol(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.deviceProtocol.toLong()
    }

    override fun getDeviceName(hashCode: Long): String {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.deviceName
    }

    override fun getVendorId(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.vendorId.toLong()
    }

    override fun getProductId(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.productId.toLong()
    }

    override fun getManufacturerName(hashCode: Long): String? {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.manufacturerName
    }

    override fun getProductName(hashCode: Long): String? {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.productName
    }

    override fun getConfigurationCount(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.configurationCount.toLong()
    }

    override fun getInterfaceCount(hashCode: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.interfaceCount.toLong()
    }

    override fun getVersion(hashCode: Long): String {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            device.version
        } else {
            throw UnsupportedOperationException()
        }
    }

    override fun getSerialNumber(hashCode: Long): String? {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        return device.serialNumber
    }

    override fun getConfiguration(hashCode: Long, index: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        val configuration = device.getConfiguration(index.toInt())
        InstanceManager.allocate(configuration)
        return configuration.hashCode().toLong()
    }

    override fun getInterface(hashCode: Long, index: Long): Long {
        val device = InstanceManager.instanceOf(hashCode) as UsbDevice
        val `interface` = device.getInterface(index.toInt())
        InstanceManager.allocate(`interface`)
        return `interface`.hashCode().toLong()
    }
}