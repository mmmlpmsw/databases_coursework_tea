package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.request.AreaThingPositionRequestDto
import ru.itmo.db.coursework.api.dto.request.AreaThingRemoveRequestDto
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

    @PostMapping("/remove")
    fun removeAreaThing(@RequestBody req: AreaThingRemoveRequestDto) {
        machineInstanceOrmService.removeInstance(req.id)
    }
}