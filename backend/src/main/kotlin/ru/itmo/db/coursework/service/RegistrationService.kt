package ru.itmo.db.coursework.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.User
import ru.itmo.db.coursework.orm.service.UserOrmService
import ru.itmo.db.coursework.orm.service.exception.ServiceException

@Service
class RegistrationService @Autowired constructor(
    private val userOrmService: UserOrmService,
    private val passwordEncoder: PasswordEncoder,
    private val defaultRegistrationMoney: Long
) {
    fun register(name: String, login: String, password: String) {
        val user = User(0, login, name, passwordEncoder.encode(password), defaultRegistrationMoney)
        if (!userOrmService.addNewUserIfNotExists(user))
            throw ServiceException("login_exists")
    }
}