package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.MachineInstanceDto
import ru.itmo.db.coursework.api.dto.request.AreaThingPositionRequestDto
import ru.itmo.db.coursework.api.dto.request.AreaThingRemoveRequestDto
import ru.itmo.db.coursework.api.dto.request.BuyMachineRequestDto
import ru.itmo.db.coursework.api.mapping.MachineInstanceDtoMapper
import ru.itmo.db.coursework.orm.service.MachineInstanceOrmService
import ru.itmo.db.coursework.service.UserService

@RestController
@RequestMapping("/area")
class AreaController @Autowired constructor(
    private val machineInstanceOrmService: MachineInstanceOrmService,
    private val machineInstanceDtoMapper: MachineInstanceDtoMapper,
    private val userService: UserService
) {
    @PostMapping("/buy")
    fun buyAndPlaceAreaThing(@RequestBody req: BuyMachineRequestDto): MachineInstanceDto {
        return machineInstanceDtoMapper.toDto(
            machineInstanceOrmService.buyMachine(
                userService.getCurrentUser().id,
                req.machineId,
                req.areaX,
                req.areaY
            )
        )
    }

    @PostMapping("/position")
    fun updateAreaThingPosition(@RequestBody req: AreaThingPositionRequestDto) {
        machineInstanceOrmService.setInstancePosition(req.instanceId, req.x, req.y)
    }

    @PostMapping("/remove")
    fun removeAreaThing(@RequestBody req: AreaThingRemoveRequestDto) {
        machineInstanceOrmService.removeInstance(req.id)
    }
}