package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import ru.itmo.db.coursework.api.dto.request.AreaThingPositionRequestDto
import ru.itmo.db.coursework.orm.service.MachineInstanceOrmService

@RestController
@RequestMapping("/area")
class AreaController @Autowired constructor(
    private val machineInstanceOrmService: MachineInstanceOrmService
) {
    @PostMapping("/buy")
    fun buyAndPlaceAreaThing() {
        // todo buy and place new area thing
    }

    @PostMapping("/position")
    fun updateAreaThingPosition(@RequestBody req: AreaThingPositionRequestDto) {
        machineInstanceOrmService.setInstancePosition(req.machineId, req.x, req.y)
    }

    @DeleteMapping
    fun removeAreaThing() {
        // todo remove area thingMachineInstanceEntity
    }
}