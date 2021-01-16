package ru.itmo.db.coursework.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

@Service("authenticationProvider")
class AuthenticationProviderImpl @Autowired constructor(
        private val userDetailsService: UserDetailsService,
        private val passwordEncoder: PasswordEncoder
): AuthenticationProvider {
    override fun authenticate(auth: Authentication): Authentication {
        val username = auth.principal.toString()
        val password = auth.credentials.toString()
        val user = userDetailsService.loadUserByUsername(username)
        if (passwordEncoder.matches(password, user.password))
            return UsernamePasswordAuthenticationToken(user.username, user.password, user.authorities)
        throw BadCredentialsException("Wrong username/password")
    }

    override fun supports(p0: Class<*>?): Boolean {
        TODO("Not yet implemented")
    }
}