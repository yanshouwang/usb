package dev.yanshouwang.usb_android

object InstanceManager {
    private val instances = mutableMapOf<Long, Instance>()

    fun instanceOf(hashCode: Long): Any? {
        return instances[hashCode]?.instance
    }

    fun allocate(instance: Any) {
        val hashCode = instance.hashCode().toLong()
        val oldInstance = instances[hashCode]
        if (oldInstance == null) {
            val newInstance = Instance(instance)
            instances[hashCode] = newInstance
        } else {
            oldInstance.increase()
        }
    }

    fun free(hashCode: Long) {
        val instance = instances[hashCode] ?: return
        instance.decrease()
        if (instance.count > 0) {
            return
        }
        instances.remove(hashCode)
    }
}

class Instance(val instance: Any) {
    private var _count = 1
    val count: Int get() = _count

    fun increase() {
        _count++
    }

    fun decrease() {
        _count--
    }
}