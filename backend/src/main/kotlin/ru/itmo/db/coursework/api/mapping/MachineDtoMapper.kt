package ru.itmo.db.coursework.api.mapping

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.MachineDto
import ru.itmo.db.coursework.model.CircuitBoard
import ru.itmo.db.coursework.model.Machine
import ru.itmo.db.coursework.model.Tea

@Service
class MachineDtoMapper @Autowired constructor(
        private val machineRecipeDtoMapper: MachineRecipeDtoMapper
) {
    fun fromDto(dto: MachineDto, circuitBoardById: Map<Int, CircuitBoard>, teaById: Map<Int, Tea>) = with(dto, {
        Machine(
                id = id,
                name = name,
                sizeX = sizeX,
                sizeY = sizeY,
                price = price,
                recipes = recipes.map{
                    machineRecipeDtoMapper.fromDto(it, circuitBoardById[it.circuitBoardId]!!, teaById)
                }.toSet()
        )
    })

    fun toDto(model: Machine) = with(model, {
        MachineDto(
                id = id,
                name = name,
                sizeX = sizeX,
                sizeY = sizeY,
                price = price,
                recipes = recipes.map(machineRecipeDtoMapper::toDto).toSet()
        )
    });
}