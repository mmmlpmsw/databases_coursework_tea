package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.request.RegisterRequestDto
import ru.itmo.db.coursework.service.RegistrationService

@RestController
@RequestMapping("/register")
class RegistrationController @Autowired constructor(
    private val registrationService: RegistrationService
) {
    @PostMapping
    fun register(@RequestBody req: RegisterRequestDto) {
        registrationService.register(req.name!!, req.login!!, req.password!!)
    }
}