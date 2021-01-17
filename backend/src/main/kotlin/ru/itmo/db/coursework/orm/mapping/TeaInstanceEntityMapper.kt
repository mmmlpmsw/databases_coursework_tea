package ru.itmo.db.coursework.orm.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.TeaInstance
import ru.itmo.db.coursework.orm.entity.TeaEntity
import ru.itmo.db.coursework.orm.entity.TeaInstanceEntity
import ru.itmo.db.coursework.orm.entity.UserEntity

@Service
class TeaInstanceEntityMapper {
    fun fromEntity(entity: TeaInstanceEntity) = with(entity, {
        TeaInstance(
            teaId = tea!!.id!!,
            amount = amount!!
        )
    })

    fun toEntity(model: TeaInstance, userId: Int) = with(model, {
        TeaInstanceEntity(
            tea = TeaEntity(id = teaId),
            user = UserEntity(userId),
            amount = amount
        )
    })
}