package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.User
import ru.itmo.db.coursework.orm.mapping.UserEntityMapper
import ru.itmo.db.coursework.orm.repository.UserRepository
import java.util.*
import javax.transaction.Transactional

@Service
open class UserOrmService @Autowired constructor(
        private val userRepository: UserRepository,
        private val userEntityMapper: UserEntityMapper
) {
    fun getByLogin(login: String): Optional<User> = Optional.ofNullable(
            userRepository.findByLogin(login)
                    .map(userEntityMapper::fromEntity)
                    .orElse(null)
    )

    fun getById(id: Int) = userRepository.findById(id).map(userEntityMapper::fromEntity)

    @Transactional
    open fun addNewUserIfNotExists(user: User): Boolean {
        if (!userRepository.existsByLogin(user.login)) {
            userRepository.save(userEntityMapper.toEntity(user).copy(id = null))
            return true
        }
        return false
    }
}