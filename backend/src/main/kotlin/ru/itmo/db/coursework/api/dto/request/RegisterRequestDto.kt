package ru.itmo.db.coursework.api.dto.request

import com.fasterxml.jackson.annotation.JsonProperty

data class RegisterRequestDto (
    @JsonProperty("login")      val login: String,
    @JsonProperty("name")       val name: String,
    @JsonProperty("password")   val password: String
)