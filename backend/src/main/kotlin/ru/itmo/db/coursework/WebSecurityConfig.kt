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
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter
import org.springframework.security.web.util.matcher.AndRequestMatcher
import org.springframework.security.web.util.matcher.AntPathRequestMatcher
import org.springframework.security.web.util.matcher.NegatedRequestMatcher
import ru.itmo.db.coursework.security.AuthenticationFilter
import ru.itmo.db.coursework.security.AuthenticationProviderImpl
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
    open fun userDefaultAuthorities() = setOf(GrantedAuthority { "USER" })

    @Autowired
    val authenticationProvider: AuthenticationProviderImpl? = null

    override fun configure(http: HttpSecurity) {
        http.cors().and().headers().disable()
            .authenticationProvider(authenticationProvider)
            .authorizeRequests()
            .antMatchers("/login").permitAll()
            .antMatchers("/register").permitAll()
            .antMatchers("/**").authenticated()
            .and().addFilterBefore(createCustomFilter(), BasicAuthenticationFilter::class.java)
            .csrf().disable()
    }

    protected open fun createCustomFilter(): AbstractAuthenticationProcessingFilter {
        val filter = AuthenticationFilter(
            NegatedRequestMatcher(
                AndRequestMatcher(
                    AntPathRequestMatcher("/login"),
                    AntPathRequestMatcher("/register")
                )
            )
        )
        filter.setAuthenticationManager(authenticationProvider!!)
        return filter
    }
}