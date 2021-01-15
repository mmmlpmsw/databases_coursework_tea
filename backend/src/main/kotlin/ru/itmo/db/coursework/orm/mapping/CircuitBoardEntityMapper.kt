package ru.itmo.db.coursework.orm.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.CircuitBoard
import ru.itmo.db.coursework.orm.entity.CircuitBoardEntity

@Service
class CircuitBoardEntityMapper {
    fun fromEntity(entity: CircuitBoardEntity) = with(entity, {
        CircuitBoard(
                id = id!!,
                name = name!!,
                sellPrice = sellPrice!!
        )
    })

    fun toEntity(model: CircuitBoard) = with(model, {
        CircuitBoardEntity(
                id = id,
                name = name,
                sellPrice = sellPrice
        )
    })
}