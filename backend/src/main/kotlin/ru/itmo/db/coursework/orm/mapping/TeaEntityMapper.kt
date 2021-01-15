package ru.itmo.db.coursework.orm.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.Tea
import ru.itmo.db.coursework.orm.entity.TeaEntity

@Service
class TeaEntityMapper {
    fun fromEntity(entity: TeaEntity) = with(entity, {
        Tea(
                id = id!!,
                name = name!!,
                price = price!!,
                description = description!!
        )
    })

    fun toEntity(model: Tea) = with(model, {
        TeaEntity(
            id = id,
            name = name,
            price = price,
            description = description
        )
    })
}