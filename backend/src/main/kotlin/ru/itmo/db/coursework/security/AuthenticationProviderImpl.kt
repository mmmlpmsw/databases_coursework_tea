package ru.itmo.db.coursework.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.core.Authentication
import org.springframework.stereotype.Service

@Service("authenticationProvider")
class AuthenticationProviderImpl @Autowired constructor(
        private val tokenService: TokenService
): AuthenticationProvider {
    override fun authenticate(auth: Authentication): Authentication {
        val tokenContainer = auth as AuthenticationToken
        val token = tokenContainer.getToken()
        val user = tokenService.getUserByToken(token) ?: throw BadCredentialsException("Bad credentials")
        return AuthenticationToken(token, user)
    }

    override fun supports(clazz: Class<*>): Boolean {
        return AuthenticationToken::class.java.isAssignableFrom(clazz)
    }
}