package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.request.BuyTeaRequestDto
import ru.itmo.db.coursework.orm.service.TeaOrmService
import ru.itmo.db.coursework.service.UserService

@RestController
@RequestMapping("/tea")
class TeaController @Autowired constructor(
    private val teaOrmService: TeaOrmService,
    private val userService: UserService
) {
    @PostMapping("/buy")
    fun buyTea(@RequestBody req: BuyTeaRequestDto) {
        teaOrmService.buyTea(userService.getCurrentUser().id, req.teaId, req.amount)
    }
}