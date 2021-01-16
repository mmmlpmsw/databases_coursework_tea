package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.TokenDto
import ru.itmo.db.coursework.api.dto.request.LoginRequestDto
import ru.itmo.db.coursework.orm.service.UserOrmService
import ru.itmo.db.coursework.security.TokenService

@RestController
@RequestMapping("/login")
class LoginController @Autowired constructor (
    private val passwordEncoder: PasswordEncoder,
    private val userOrmService: UserOrmService,
    private val tokenService: TokenService
) {
    @PostMapping
    fun login(@RequestBody req: LoginRequestDto): Any {
        val user = userOrmService.getByLogin(req.username!!)
        if (user.isPresent && passwordEncoder.matches(req.password!!, user.get().passwordHash)) {
            val token = tokenService.createToken(user.get())
            return TokenDto(token)
        }
        return ResponseEntity<Any>(HttpStatus.BAD_REQUEST)
    }
}