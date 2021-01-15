package ru.itmo.db.coursework.orm.entity.id

import ru.itmo.db.coursework.orm.entity.CircuitBoardEntity
import ru.itmo.db.coursework.orm.entity.UserEntity
import java.io.Serializable

data class CircuitBoardInstanceEntityId (
        var userId: UserEntity? = null,
        var modelId: CircuitBoardEntity? = null
): Serializable