package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.BootstrapDto
import ru.itmo.db.coursework.api.mapping.*
import ru.itmo.db.coursework.orm.service.*
import ru.itmo.db.coursework.service.UserService

@RestController
@RequestMapping("/bootstrap")
open class BootstrapController @Autowired constructor(
    private val userService: UserService,
    private val userDtoMapper: UserDtoMapper,
    private val machineOrmService: MachineOrmService,
    private val machineDtoMapper: MachineDtoMapper,
    private val teaOrmService: TeaOrmService,
    private val teaDtoMapper: TeaDtoMapper,
    private val circuitBoardOrmService: CircuitBoardOrmService,
    private val circuitBoardDtoMapper: CircuitBoardDtoMapper,
    private val machineInstanceOrmService: MachineInstanceOrmService,
    private val machineInstanceDtoMapper: MachineInstanceDtoMapper,
    private val teaInstanceOrmService: TeaInstanceOrmService,
    private val teaInstanceDtoMapper: TeaInstanceDtoMapper,
    private val circuitBoardInstanceOrmService: CircuitBoardInstanceOrmService,
    private val circuitBoardInstanceDtoMapper: CircuitBoardInstanceDtoMapper
) {
    @GetMapping
    @ResponseBody
    @PreAuthorize("hasAuthority('USER')")
    open fun bootstrap(): BootstrapDto {
        val currentUser = userService.getCurrentUser()
        return BootstrapDto(
            currentUser = userDtoMapper.toDto(currentUser),
            machines = machineOrmService.getAll().map(machineDtoMapper::toDto),
            teas = teaOrmService.getAll().map(teaDtoMapper::toDto),
            circuitBoards = circuitBoardOrmService.getAll().map(circuitBoardDtoMapper::toDto),
            machineInstances = machineInstanceOrmService.getAllByUser(currentUser.id).map(machineInstanceDtoMapper::toDto),
            teaInstances = teaInstanceOrmService.getAllByUser(currentUser.id).map(teaInstanceDtoMapper::toDto),
            circuitBoardInstances = circuitBoardInstanceOrmService.getAllByUser(currentUser.id).map(circuitBoardInstanceDtoMapper::toDto)
        )
    }
}