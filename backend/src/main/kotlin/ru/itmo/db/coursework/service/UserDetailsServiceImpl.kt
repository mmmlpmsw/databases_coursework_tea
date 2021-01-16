package ru.itmo.db.coursework.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.orm.service.UserOrmService
import java.util.*

@Service("userDetailsService")
class UserDetailsServiceImpl @Autowired constructor(
        private val userOrmService: UserOrmService,
        private val userDefaultAuthorities: Set<GrantedAuthority>
): UserDetailsService {
    @Throws(UsernameNotFoundException::class)
    override fun loadUserByUsername(login: String): UserDetails {
        val user = userOrmService.getByLogin(login).orElseThrow { UsernameNotFoundException("User not found") }
        return User(user.login, Base64.getEncoder().encodeToString(user.passwordHash), userDefaultAuthorities)
    }
}