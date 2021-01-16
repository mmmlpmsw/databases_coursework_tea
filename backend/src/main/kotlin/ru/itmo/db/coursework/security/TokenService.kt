package ru.itmo.db.coursework.security

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.User
import java.util.*

@Service
class TokenService {
    private val tokens: MutableMap<String, User> = mutableMapOf()

    fun getUserByToken(token: String): User? {
        return tokens[token]
    }

    fun createToken(user: User): String {
        val token = UUID.randomUUID().toString()
        tokens[token] = user
        return token
    }

    fun remove(token: String) {
        tokens.remove(token)
    }
}