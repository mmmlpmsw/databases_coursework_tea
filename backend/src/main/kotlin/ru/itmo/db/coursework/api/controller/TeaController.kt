package ru.itmo.db.coursework.api.controller

import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/tea")
class TeaController {
    @PutMapping
    fun buyTea() {
        // todo buy new tea and place to user inventory
    }
}