package ru.itmo.db.coursework.api.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController
import ru.itmo.db.coursework.api.dto.BootstrapDto
import ru.itmo.db.coursework.api.mapping.MachineDtoMapper
import ru.itmo.db.coursework.orm.service.MachineOrmService

@RestController
@RequestMapping("/bootstrap")
class BootstrapController @Autowired constructor(
        private val machineOrmService: MachineOrmService,
        private val machineDtoMapper: MachineDtoMapper
) {
    @GetMapping
    @ResponseBody
    fun bootstrap() = BootstrapDto(
            machines = machineOrmService.getAllMachines().map(machineDtoMapper::toDto)
    )
}