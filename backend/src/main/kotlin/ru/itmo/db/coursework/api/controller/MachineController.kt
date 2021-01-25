package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import ru.itmo.db.coursework.api.dto.ProduceCircuitBoardCompletionTime
import ru.itmo.db.coursework.api.dto.request.MachineProduceCircuitBoardRequestDto
import ru.itmo.db.coursework.api.dto.request.UpdateMachineStateRequestDto
import ru.itmo.db.coursework.orm.service.MachineInstanceOrmService
import ru.itmo.db.coursework.service.UserService

@RestController
@RequestMapping("/machine")
class MachineController @Autowired constructor(
        private val machineInstanceOrmService: MachineInstanceOrmService,
        private val userService: UserService
) {
    @ResponseBody
    @PostMapping("/produce")
    fun produceCircuitBoardInstance(@RequestBody req: MachineProduceCircuitBoardRequestDto): ProduceCircuitBoardCompletionTime {
        machineInstanceOrmService.produceCircuitBoardInstance(userService.getCurrentUser().id, req.instanceId, req.recipeId)
        return ProduceCircuitBoardCompletionTime(machineInstanceOrmService.getById(req.instanceId).currentRecipeCompletionTime)
    }

    @PostMapping("/update")
    fun updateMachineState(@RequestBody req: UpdateMachineStateRequestDto) {
        machineInstanceOrmService.updateState(userService.getCurrentUser().id, req.instanceId)
    }
}