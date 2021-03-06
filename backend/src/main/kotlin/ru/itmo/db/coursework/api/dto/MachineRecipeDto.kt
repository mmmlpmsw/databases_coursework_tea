package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class MachineRecipeDto (
        var id: Int,
        @get:JsonProperty("circuit_board_id")
        var circuitBoardId: Int,
        @get:JsonProperty("circuit_board_amount")
        var circuitBoardAmount: Int,
        @get:JsonProperty("work_time")
        var workTime: Long,
        var price: Long,
        var teas: Map<Int, Int>
)