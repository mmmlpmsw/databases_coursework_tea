package ru.itmo.db.coursework

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.core.env.Environment
import org.springframework.core.env.StandardEnvironment
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.core.GrantedAuthority
import java.util.*

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
open class WebSecurityConfig : WebSecurityConfigurerAdapter() {
    @Autowired
    val env: Environment = StandardEnvironment()

    @Bean
    open fun userPasswordSalt(): ByteArray = Base64.getDecoder().decode(
            env.getRequiredProperty("user.password.salt")
    )

    @Bean
    open fun userDefaultAuthorities() = setOf(GrantedAuthority { "ROLE_USER" })

    override fun configure(http: HttpSecurity) {
        http    .authorizeRequests()
                .anyRequest().authenticated()
                .and().formLogin()
                .and().logout().permitAll()
                .and().httpBasic()
    }
}