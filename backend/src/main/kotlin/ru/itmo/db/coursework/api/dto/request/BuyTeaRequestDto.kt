package ru.itmo.db.coursework.api.dto.request

import com.fasterxml.jackson.annotation.JsonProperty

data class BuyTeaRequestDto(
    @JsonProperty("tea_id") val teaId: Int,
    @JsonProperty("amount") val amount: Int
)
