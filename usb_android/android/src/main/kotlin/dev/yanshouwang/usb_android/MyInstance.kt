package dev.yanshouwang.usb_android

class MyInstance(val instance: Any) {
    private var _count = 1
    val count: Int get() = _count

    fun increase() {
        _count++
    }

    fun decrease() {
        _count--
    }
}