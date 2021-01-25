package ru.itmo.db.coursework.api.dto.request

import com.fasterxml.jackson.annotation.JsonProperty

data class UpdateMachineStateRequestDto(
    @JsonProperty("instance_id") val instanceId: Int
)
