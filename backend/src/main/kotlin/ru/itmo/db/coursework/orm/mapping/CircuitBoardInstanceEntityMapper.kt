package ru.itmo.db.coursework.orm.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.CircuitBoardInstance
import ru.itmo.db.coursework.orm.entity.CircuitBoardEntity
import ru.itmo.db.coursework.orm.entity.CircuitBoardInstanceEntity
import ru.itmo.db.coursework.orm.entity.UserEntity

@Service
class CircuitBoardInstanceEntityMapper {
    fun fromEntity(entity: CircuitBoardInstanceEntity) = with(entity, {
        CircuitBoardInstance(
            modelId = model!!.id!!,
            amount = amount!!
        )
    })

    fun toEntity(model: CircuitBoardInstance, userId: Int) = with(model, {
        CircuitBoardInstanceEntity(
            model = CircuitBoardEntity(modelId),
            user = UserEntity(userId),
            amount = amount
        )
    })
}