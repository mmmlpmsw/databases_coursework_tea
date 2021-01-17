package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class CircuitBoardInstanceDto(
    @get:JsonProperty("model_id")
    val modelId: Int,
    val amount: Int
)
