package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class MachineInstanceDto(
    val id: Int,
    @get:JsonProperty("machine_id")
    val machineId: Int,
    @get:JsonProperty("area_x")
    val areaX: Int,
    @get:JsonProperty("area_y")
    val areaY: Int,
    @get:JsonProperty("current_recipe_id")
    val currentRecipeId: Int? = null,
    @get:JsonProperty("current_recipe_completion_time")
    val currentRecipeCompletionTime: Long? = null
)
