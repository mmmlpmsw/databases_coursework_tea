package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.orm.mapping.MachineEntityMapper
import ru.itmo.db.coursework.orm.repository.MachineRepository

@Service
class MachineOrmService @Autowired constructor(
        private val machineRepository: MachineRepository,
        private val machineEntityMapper: MachineEntityMapper
) {
    fun getAll() = machineRepository.findAll().map(machineEntityMapper::fromEntity).toSet()
}