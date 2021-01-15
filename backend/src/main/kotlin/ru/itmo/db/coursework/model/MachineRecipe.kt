package ru.itmo.db.coursework.model

data class MachineRecipe(
        var id: Int,
        var circuitBoard: CircuitBoard,
        var circuitBoardAmount: Int,
        var workTime: Long,
        var price: Long,
        var teas: Map<Tea, Int>
)
