package ru.itmo.db.coursework.model

data class Machine(
        var id: Int,
        var name: String,
        var sizeX: Int,
        var sizeY: Int,
        var price: Long,
        var recipes: Set<MachineRecipe>
)
