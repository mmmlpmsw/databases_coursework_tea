package ru.itmo.db.coursework.security

import org.springframework.security.authentication.AbstractAuthenticationToken
import org.springframework.security.core.GrantedAuthority

class AuthenticationToken : AbstractAuthenticationToken {
    private val token: String
    private val userId: Int?

    constructor(token: String) : super(null) {
        this.token = token
        userId = null
        isAuthenticated = false
    }

    constructor(token: String, userId: Int, authorities: Set<GrantedAuthority>) : super(authorities) {
        this.token = token
        this.userId = userId
        isAuthenticated = true
    }

    fun getToken() = token
    fun getUserId() = userId

    override fun getCredentials(): Any {
        return token
    }

    override fun getPrincipal(): Any? {
        return userId
    }
}