package ru.itmo.db.coursework.model

data class User(
        var id: Int,
        var login: String,
        var name: String,
        var passwordHash: ByteArray,
        var money: Long
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as User

        if (id != other.id) return false
        if (login != other.login) return false
        if (name != other.name) return false
        if (!passwordHash.contentEquals(other.passwordHash)) return false
        if (money != other.money) return false

        return true
    }

    override fun hashCode(): Int {
        var result = id
        result = 31 * result + login.hashCode()
        result = 31 * result + name.hashCode()
        result = 31 * result + passwordHash.contentHashCode()
        result = 31 * result + money.hashCode()
        return result
    }
}
