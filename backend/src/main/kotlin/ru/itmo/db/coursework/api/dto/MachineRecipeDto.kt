package ru.itmo.db.coursework.api.dto

data class MachineRecipeDto (
        var id: Int,
        var circuitBoardId: Int,
        var circuitBoardAmount: Int,
        var workTime: Long,
        var price: Long,
        var teas: Map<Int, Int>
)