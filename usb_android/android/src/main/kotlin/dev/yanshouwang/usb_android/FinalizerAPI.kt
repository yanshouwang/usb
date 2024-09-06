package dev.yanshouwang.usb_android

class FinalizerAPI : FinalizerHostAPI {
    override fun free(hashCode: Long) {
        InstanceManager.free(hashCode)
    }
}