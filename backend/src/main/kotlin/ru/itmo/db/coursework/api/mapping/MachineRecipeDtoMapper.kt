package ru.itmo.db.coursework.api.mapping

import org.springframework.stereotype.Service
import ru.itmo.db.coursework.api.dto.MachineRecipeDto
import ru.itmo.db.coursework.model.CircuitBoard
import ru.itmo.db.coursework.model.MachineRecipe
import ru.itmo.db.coursework.model.Tea

@Service
class MachineRecipeDtoMapper {
    fun fromDto(dto: MachineRecipeDto, circuitBoard: CircuitBoard, teaById: Map<Int, Tea>) = with(dto, {
        MachineRecipe(
                id = id,
                circuitBoard = circuitBoard,
                circuitBoardAmount = circuitBoardAmount,
                workTime = workTime,
                price = price,
                teas = teas.mapKeys { teaById[it.key]!! }
        )
    })

    fun toDto(model: MachineRecipe) = with(model, {
        MachineRecipeDto(
                id = id,
                circuitBoardId = circuitBoard.id,
                circuitBoardAmount = circuitBoardAmount,
                workTime = workTime,
                price = price,
                teas = teas.mapKeys { it.key.id }
        )
    })
}