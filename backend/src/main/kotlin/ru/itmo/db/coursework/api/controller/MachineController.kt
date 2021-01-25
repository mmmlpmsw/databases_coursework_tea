package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.request.MachineProduceCircuitBoardRequestDto
import ru.itmo.db.coursework.orm.service.MachineInstanceOrmService
import ru.itmo.db.coursework.service.UserService

@RestController
@RequestMapping("/machine")
class MachineController @Autowired constructor(
        private val machineInstanceOrmService: MachineInstanceOrmService,
        private val userService: UserService
) {
    @PostMapping("/produce")
    fun produceCircuitBoardInstance(@RequestBody req: MachineProduceCircuitBoardRequestDto) {
        machineInstanceOrmService.produceCircuitBoardInstance(userService.getCurrentUser().id, req.instanceId, req.recipeId)
    }
}