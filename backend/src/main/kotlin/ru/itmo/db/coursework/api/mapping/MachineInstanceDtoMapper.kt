package ru.itmo.db.coursework.api.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.MachineInstanceDto
import ru.itmo.db.coursework.model.MachineInstance

@Service
class MachineInstanceDtoMapper {
    fun fromDto(dto: MachineInstanceDto) = with(dto, {
        MachineInstance(
            id = id,
            machineId = machineId,
            areaX = areaX,
            areaY = areaY,
            currentRecipeId = currentRecipeId,
            currentRecipeCompletionTime = currentRecipeCompletionTime
        )
    })

    fun toDto(model: MachineInstance) = with(model, {
        MachineInstanceDto(
            id = id,
            machineId = machineId,
            areaX = areaX,
            areaY = areaY,
            currentRecipeId = currentRecipeId,
            currentRecipeCompletionTime = currentRecipeCompletionTime
        )
    })
}