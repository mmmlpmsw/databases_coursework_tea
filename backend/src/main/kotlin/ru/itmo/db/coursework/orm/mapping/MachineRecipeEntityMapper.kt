package ru.itmo.db.coursework.orm.mapping

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.MachineRecipe
import ru.itmo.db.coursework.orm.entity.MachineRecipeEntity
import ru.itmo.db.coursework.orm.entity.MachineRecipeTeaEntity
import java.util.stream.Collectors

@Service
class MachineRecipeEntityMapper @Autowired constructor(
        private val circuitBoardEntityMapper: CircuitBoardEntityMapper,
        private val teaEntityMapper: TeaEntityMapper
) {
    fun fromEntity(entity: MachineRecipeEntity) = with(entity, {
        MachineRecipe(
                id = id!!,
                circuitBoard = circuitBoardEntityMapper.fromEntity(circuitBoard!!),
                circuitBoardAmount = circuitBoardAmount!!,
                workTime = workTime!!,
                price = price!!,
                teas = teas.stream().collect(Collectors.toMap({ teaEntityMapper.fromEntity(it.tea!!) }, { it.amount!! }))
        )
    })

    fun toEntity(model: MachineRecipe, machineId: Int) = with(model, {
        val result = MachineRecipeEntity(
                id = id,
                machineId = machineId,
                circuitBoard = circuitBoardEntityMapper.toEntity(circuitBoard),
                circuitBoardAmount = circuitBoardAmount,
                workTime = workTime,
                price = price
        )
        result.teas = teas.keys.stream().map {
            MachineRecipeTeaEntity(id, teaEntityMapper.toEntity(it), teas[it])
        }.collect(Collectors.toSet())
        result
    })
}