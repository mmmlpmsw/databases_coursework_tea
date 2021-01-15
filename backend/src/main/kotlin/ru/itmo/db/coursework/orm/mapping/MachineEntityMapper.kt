package ru.itmo.db.coursework.orm.mapping

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.Machine
import ru.itmo.db.coursework.orm.entity.MachineEntity

@Service
class MachineEntityMapper @Autowired constructor(
        private val machineRecipeEntityMapper: MachineRecipeEntityMapper
) {
    fun fromEntity(entity: MachineEntity) = with(entity, {
        Machine(
                id = id!!,
                name = name!!,
                sizeX = sizeX!!,
                sizeY = sizeY!!,
                price = price!!,
                recipes = recipes.map(machineRecipeEntityMapper::fromEntity).toSet()
        )
    })

    fun toEntity(model: Machine) = with(model, {
        MachineEntity(
                id = id,
                name = name,
                sizeX = sizeX,
                sizeY = sizeY,
                price = price,
                recipes = recipes.map(machineRecipeEntityMapper::toEntity).toSet()
        )
    })
}