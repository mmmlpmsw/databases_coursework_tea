package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class ProduceCircuitBoardCompletionTime(
    @JsonProperty("completion_time") val completionTime: Long?
)
