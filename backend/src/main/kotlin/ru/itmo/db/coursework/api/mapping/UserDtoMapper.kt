package ru.itmo.db.coursework.api.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.UserDto
import ru.itmo.db.coursework.model.User

@Service
class UserDtoMapper {
    fun fromDto(dto: UserDto, passwordHash: String) = with(dto, {
        User(
            id = id,
            login = login,
            name = name,
            passwordHash = passwordHash,
            money = money
        )
    })

    fun toDto(model: User) = with(model, {
        UserDto(
            id = id,
            login = login,
            name = name,
            money = money
        )
    })
}