package ru.itmo.db.coursework.orm.entity.id

import ru.itmo.db.coursework.orm.entity.TeaEntity
import ru.itmo.db.coursework.orm.entity.UserEntity
import java.io.Serializable

data class TeaInstanceEntityId (
        var tea: TeaEntity,
        var user: UserEntity
): Serializable