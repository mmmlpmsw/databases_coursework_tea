package ru.itmo.db.coursework.api.dto.request

import com.fasterxml.jackson.annotation.JsonProperty

data class BuyMachineRequestDto(
    @JsonProperty("machine_id") val machineId: Int,
    @JsonProperty("area_x") val areaX: Int,
    @JsonProperty("area_y") val areaY: Int
)
