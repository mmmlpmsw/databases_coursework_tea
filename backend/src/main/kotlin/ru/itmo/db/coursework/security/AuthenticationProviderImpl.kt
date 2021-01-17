package ru.itmo.db.coursework.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.core.Authentication
import org.springframework.security.core.GrantedAuthority
import org.springframework.stereotype.Service

@Service("authenticationProvider")
class AuthenticationProviderImpl @Autowired constructor(
        private val tokenService: TokenService,
        private val userDefaultAuthorities: Set<GrantedAuthority>
): AuthenticationProvider, AuthenticationManager {
    override fun authenticate(auth: Authentication): Authentication {
        if (!AuthenticationToken::class.java.isAssignableFrom(auth.javaClass))
            throw BadCredentialsException("Bad credentials")

        val tokenContainer = auth as AuthenticationToken
        val token = tokenContainer.getToken()
        val user = tokenService.getUserByToken(token) ?: throw BadCredentialsException("Bad credentials")
        return AuthenticationToken(token, user.id, userDefaultAuthorities)
    }

    override fun supports(clazz: Class<*>): Boolean {
        return true
    }
}