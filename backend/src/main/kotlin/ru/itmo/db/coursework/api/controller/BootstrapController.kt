package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.BootstrapDto
import ru.itmo.db.coursework.api.mapping.CircuitBoardDtoMapper
import ru.itmo.db.coursework.api.mapping.MachineDtoMapper
import ru.itmo.db.coursework.api.mapping.TeaDtoMapper
import ru.itmo.db.coursework.api.mapping.UserDtoMapper
import ru.itmo.db.coursework.orm.service.CircuitBoardOrmService
import ru.itmo.db.coursework.orm.service.MachineOrmService
import ru.itmo.db.coursework.orm.service.TeaOrmService
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
    private val circuitBoardDtoMapper: CircuitBoardDtoMapper
) {
    @GetMapping
    @ResponseBody
    @PreAuthorize("hasAuthority('USER')")
    open fun bootstrap() = BootstrapDto(
        currentUser = userDtoMapper.toDto(userService.getCurrentUser()),
        machines = machineOrmService.getAll().map(machineDtoMapper::toDto),
        teas = teaOrmService.getAll().map(teaDtoMapper::toDto),
        circuitBoards = circuitBoardOrmService.getAll().map(circuitBoardDtoMapper::toDto)
    )
}