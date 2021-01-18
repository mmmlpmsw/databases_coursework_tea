package ru.itmo.db.coursework.orm.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.MachineInstance
import ru.itmo.db.coursework.orm.entity.MachineEntity
import ru.itmo.db.coursework.orm.entity.MachineInstanceEntity
import ru.itmo.db.coursework.orm.entity.MachineRecipeEntity
import ru.itmo.db.coursework.orm.entity.UserEntity

@Service
class MachineInstanceEntityMapper {
    fun fromEntity(entity: MachineInstanceEntity) = with(entity, {
        MachineInstance(
            id = id!!,
            machineId = machine!!.id!!,
            areaX = areaX!!,
            areaY = areaY!!,
            currentRecipeId = currentRecipe?.id,
            currentRecipeCompletionTime = currentRecipeCompletionTime
        )
    })

    fun toEntity(model: MachineInstance, userId: Int) = with(model, {
        MachineInstanceEntity(
            id = id,
            user = UserEntity(id = userId),
            machine = MachineEntity(id = machineId),
            areaX = areaX,
            areaY = areaY,
            currentRecipe = if (currentRecipeId != null) MachineRecipeEntity(id = currentRecipeId) else null,
            currentRecipeCompletionTime = currentRecipeCompletionTime
        )
    })
}