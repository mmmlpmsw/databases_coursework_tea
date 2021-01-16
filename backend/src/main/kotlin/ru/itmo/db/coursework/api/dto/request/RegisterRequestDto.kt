package ru.itmo.db.coursework.api.dto.request

data class RegisterRequestDto (
    val login: String? = null,
    val name: String? = null,
    val password: String? = null
)