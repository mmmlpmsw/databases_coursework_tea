package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.orm.mapping.MachineInstanceEntityMapper
import ru.itmo.db.coursework.orm.repository.MachineInstanceRepository

@Service
class MachineInstanceOrmService @Autowired constructor(
    private val machineInstanceRepository: MachineInstanceRepository,
    private val machineInstanceEntityMapper: MachineInstanceEntityMapper
) {
    fun getAllByUser(userId: Int) =
        machineInstanceRepository
            .findAllByUserId(userId)
            .map(machineInstanceEntityMapper::fromEntity)
}