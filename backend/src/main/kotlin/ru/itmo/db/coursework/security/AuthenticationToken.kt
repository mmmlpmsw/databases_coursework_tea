package ru.itmo.db.coursework.security

import org.springframework.security.authentication.AbstractAuthenticationToken
import org.springframework.security.core.GrantedAuthority
import ru.itmo.db.coursework.model.User

class AuthenticationToken : AbstractAuthenticationToken {
    private val token: String
    private val user: User?

    constructor(token: String) : super(null) {
        this.token = token
        user = null
        isAuthenticated = false
    }

    constructor(token: String, user: User) : super(setOf(GrantedAuthority { "USER" })) {
        this.token = token
        this.user = user
        isAuthenticated = true
    }

    fun getToken() = token
    fun getUser() = user

    override fun getCredentials(): Any {
        return token
    }

    override fun getPrincipal(): Any? {
        return user
    }
}