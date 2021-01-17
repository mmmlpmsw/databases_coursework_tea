package ru.itmo.db.coursework.model

data class MachineInstance(
    val id: Int,
    val machineId: Int,
    val areaX: Int,
    val areaY: Int,
    val currentRecipeId: Int? = null,
    val currentRecipeCompletionTime: Long? = null
)
