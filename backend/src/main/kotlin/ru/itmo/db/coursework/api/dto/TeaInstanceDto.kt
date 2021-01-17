package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class TeaInstanceDto(
    @get:JsonProperty("tea_id")
    val teaId: Int,
    val amount: Int
)
