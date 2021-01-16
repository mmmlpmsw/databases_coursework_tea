package ru.itmo.db.coursework.orm.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.User
import ru.itmo.db.coursework.orm.entity.UserEntity
import java.util.*

@Service
class UserEntityMapper {
    fun fromEntity(entity: UserEntity) = with(entity, {
        User(
                id = id!!,
                login = login!!,
                name = name!!,
                passwordHash = passwordHash!!,
                money = money
        )
    })

    fun toEntity(model: User) = with(model, {
        UserEntity(
                id = id,
                login = login,
                name = name,
                passwordHash = passwordHash,
                money = money
        )
    })
}