package ru.itmo.db.coursework.api.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.CircuitBoardDto
import ru.itmo.db.coursework.model.CircuitBoard

@Service
class CircuitBoardDtoMapper {
    fun fromDto(dto: CircuitBoardDto) = with(dto, {
        CircuitBoard(
            id = id!!,
            name = name!!,
            sellPrice = sellPrice!!
        )
    })

    fun toDto(model: CircuitBoard) = with(model, {
        CircuitBoardDto(
            id = id,
            name = name,
            sellPrice = sellPrice
        )
    })
}