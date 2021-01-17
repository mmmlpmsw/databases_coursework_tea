package ru.itmo.db.coursework.api.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.CircuitBoardInstanceDto
import ru.itmo.db.coursework.model.CircuitBoardInstance

@Service
class CircuitBoardInstanceDtoMapper {
    fun fromDto(dto: CircuitBoardInstanceDto) = with(dto, {
        CircuitBoardInstance(
            modelId = modelId,
            amount = amount
        )
    })

    fun toDto(model: CircuitBoardInstance) = with(model, {
        CircuitBoardInstanceDto(
            modelId = modelId,
            amount = amount
        )
    })
}