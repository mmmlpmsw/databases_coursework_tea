package ru.itmo.db.coursework.api.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RestController
import java.util.*

@RestController
@RequestMapping("/")
class TestController {
    @GetMapping("test")
    fun test(): String {
        return "Hello! Today is ${Date()}"
    }
}