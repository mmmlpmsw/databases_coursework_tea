package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

class CircuitBoardDto (
    val id: Int? = null,
    val name: String? = null,
    @get:JsonProperty("sell_price")
    val sellPrice: Long? = null
)