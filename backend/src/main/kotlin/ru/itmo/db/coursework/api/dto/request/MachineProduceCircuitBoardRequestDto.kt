package ru.itmo.db.coursework.api.dto.request

import com.fasterxml.jackson.annotation.JsonProperty

data class MachineProduceCircuitBoardRequestDto (
        @JsonProperty("instance_id") val instanceId: Int,
        @JsonProperty("recipe_id") val recipeId: Int,
)