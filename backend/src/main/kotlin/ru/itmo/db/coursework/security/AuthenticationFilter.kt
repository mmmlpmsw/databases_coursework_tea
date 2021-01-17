package ru.itmo.db.coursework.security

import org.springframework.security.core.Authentication
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter
import org.springframework.security.web.util.matcher.RequestMatcher
import java.io.IOException
import java.util.*
import javax.servlet.FilterChain
import javax.servlet.ServletException
import javax.servlet.ServletRequest
import javax.servlet.ServletResponse
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class AuthenticationFilter(matcher: RequestMatcher): AbstractAuthenticationProcessingFilter(matcher) {
    companion object {
        private const val TOKEN_HEADER = "x-auth-token"
    }

    @Throws(IOException::class, ServletException::class)
    override fun doFilter(request: ServletRequest?, response: ServletResponse?, chain: FilterChain) {
        val token: String? = getTokenValue(request as HttpServletRequest)
//        println("filter token: $token")
        // This filter only applies if the header is present
        if (token.isNullOrEmpty()) {
            chain.doFilter(request, response)
            return
        }

        // On success keep going on the chain
        setAuthenticationSuccessHandler { request1, response1, _ -> chain.doFilter(request1, response1) }
        super.doFilter(request, response, chain)
    }

    override fun attemptAuthentication(request: HttpServletRequest, response: HttpServletResponse): Authentication? {
        val tokenValue = getTokenValue(request)
//        println("auth token: $tokenValue")
        if (tokenValue.isNullOrEmpty())
            return null

        val token = AuthenticationToken(tokenValue)
        token.details = authenticationDetailsSource.buildDetails(request)
        return this.authenticationManager.authenticate(token)
    }

    private fun getTokenValue(req: HttpServletRequest): String? {
        return Collections.list(req.headerNames).stream()
            .filter { header -> header.equals(TOKEN_HEADER, ignoreCase = true) }
            .map { header -> req.getHeader(header) }
            .findFirst()
            .orElse(null)
    }
}