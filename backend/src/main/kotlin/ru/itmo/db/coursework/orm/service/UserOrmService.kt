package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.User
import ru.itmo.db.coursework.orm.mapping.UserEntityMapper
import ru.itmo.db.coursework.orm.repository.UserRepository
import java.util.*

@Service
class UserOrmService @Autowired constructor(
        private val userRepository: UserRepository,
        private val userEntityMapper: UserEntityMapper
) {
    fun getByLogin(login: String): Optional<User> = Optional.ofNullable(
            userRepository.findByLogin(login)
                    .map(userEntityMapper::fromEntity)
                    .orElse(null)
    )
}