package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class MachineDto(
        var id: Int,
        var name: String,
        @get:JsonProperty("size_x")
        var sizeX: Int,
        @get:JsonProperty("size_y")
        var sizeY: Int,
        var price: Long,
        var recipes: Set<MachineRecipeDto>
)
