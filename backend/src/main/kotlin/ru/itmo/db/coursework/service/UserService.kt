package ru.itmo.db.coursework.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.User
import ru.itmo.db.coursework.orm.service.UserOrmService

@Service
class UserService @Autowired constructor(
    private val userOrmService: UserOrmService
) {
    @PreAuthorize("hasAuthority('USER')")
    fun getCurrentUser(): User {
        val userId = SecurityContextHolder.getContext().authentication.principal as Int
        return userOrmService.getById(userId).get()
    }
}