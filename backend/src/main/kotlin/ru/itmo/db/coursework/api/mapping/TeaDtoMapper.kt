package ru.itmo.db.coursework.api.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.TeaDto
import ru.itmo.db.coursework.model.Tea

@Service
class TeaDtoMapper {
    fun fromDto(dto: TeaDto) = with(dto, {
        Tea(
                id = id,
                name = name,
                price = price,
                description = description
        )
    })

    fun toDto(model: Tea) = with(model, {
        TeaDto(
                id = id,
                name = name,
                price = price,
                description = description
        )
    })
}