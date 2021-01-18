package ru.itmo.db.coursework.api.dto.request

import com.fasterxml.jackson.annotation.JsonProperty

data class AreaThingRemoveRequestDto (
    @JsonProperty("id") val id: Int
)