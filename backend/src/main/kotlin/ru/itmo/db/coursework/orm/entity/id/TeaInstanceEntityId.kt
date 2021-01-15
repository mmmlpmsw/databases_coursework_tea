package ru.itmo.db.coursework.orm.entity.id

import ru.itmo.db.coursework.orm.entity.TeaEntity
import ru.itmo.db.coursework.orm.entity.UserEntity
import java.io.Serializable

data class TeaInstanceEntityId (
        var tea: TeaEntity? = null,
        var user: UserEntity? = null
): Serializable