package ru.itmo.db.coursework.api.dto.request

import com.fasterxml.jackson.annotation.JsonProperty

data class AreaThingPositionRequestDto(
    @JsonProperty("machine_id") val machineId: Int,
    @JsonProperty("x") val x: Int,
    @JsonProperty("y") val y: Int
)