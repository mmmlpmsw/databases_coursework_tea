package ru.itmo.db.coursework.api.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.TeaInstanceDto
import ru.itmo.db.coursework.model.TeaInstance

@Service
class TeaInstanceDtoMapper {
    fun fromDto(dto: TeaInstanceDto) = with(dto, {
        TeaInstance(
            teaId = teaId,
            amount = amount
        )
    })

    fun toDto(model: TeaInstance) = with(model, {
        TeaInstanceDto(
            teaId = teaId,
            amount = amount
        )
    })
}