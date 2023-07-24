package dev.yanshouwang.usb

import io.flutter.plugin.common.BinaryMessenger

class MyCollector : MyCollectorHostApi {
    private val instances = mutableMapOf<Long, MyInstance>()

    fun instanceOf(hashCode: Long): Any? {
        return instances[hashCode]?.instance
    }

    fun allocate(instance: Any) {
        val hashCode = instance.hashCode().toLong()
        val oldInstance = instances[hashCode]
        if (oldInstance == null) {
            val newInstance = MyInstance(instance)
            instances[hashCode] = newInstance
        } else {
            oldInstance.increase()
        }
    }

    override fun free(hashCode: Long) {
        val instance = instances[hashCode] ?: return
        instance.decrease()
        if (instance.count > 0) {
            return
        }
        instances.remove(hashCode)
    }
}