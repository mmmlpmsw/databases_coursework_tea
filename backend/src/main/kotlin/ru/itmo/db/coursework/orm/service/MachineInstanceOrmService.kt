package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.MachineInstance
import ru.itmo.db.coursework.orm.entity.MachineInstanceEntity
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

    fun add(instance: MachineInstance, userId: Int): MachineInstanceEntity =
        machineInstanceRepository.save(machineInstanceEntityMapper.toEntity(instance, userId))

    fun addAll(instances: MutableIterable<MachineInstance>, userId: Int): MutableIterable<MachineInstanceEntity> =
        machineInstanceRepository.saveAll(instances.map {machineInstanceEntityMapper.toEntity(it, userId)})
}