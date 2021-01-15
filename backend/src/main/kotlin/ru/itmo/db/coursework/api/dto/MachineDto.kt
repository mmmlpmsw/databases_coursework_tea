package ru.itmo.db.coursework.api.dto

data class MachineDto(
        var id: Int,
        var name: String,
        var sizeX: Int,
        var sizeY: Int,
        var price: Long,
        var recipes: Set<MachineRecipeDto>
)
