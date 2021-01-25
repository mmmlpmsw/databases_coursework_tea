package ru.itmo.db.coursework.orm.service

import org.hibernate.service.spi.ServiceException
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

    fun removeInstance(instanceId: Int) {
        machineInstanceRepository.deleteById(instanceId)
    }

    fun buyMachine(userId: Int, machineId: Int, areaX: Int, areaY: Int): MachineInstance {
        // Validation is in database routine
        val result = machineInstanceRepository.buyMachine(userId, machineId, areaX, areaY)
        if (result == -1)
            throw ServiceException("machine_purchase_failed")
        return machineInstanceEntityMapper.fromEntity(machineInstanceRepository.findById(result).get())
    }

    fun setInstancePosition(machineInstanceId: Int, x: Int, y: Int) {
        val allEntities = machineInstanceRepository.findAll()
        val instance = machineInstanceRepository.findById(machineInstanceId)
            .orElseThrow{ ServiceException("no_such_machine_instance") }
        if (!validateMachinePosition(instance, allEntities.toSet()))
            throw ServiceException("bad_position")
        machineInstanceRepository.setInstancePosition(machineInstanceId, x, y)
    }

    // todo this should be in service level
    private fun validateMachinePosition(instance: MachineInstanceEntity, allInstances: Collection<MachineInstanceEntity>): Boolean {
        val leftX = instance.areaX!!
        val topY = instance.areaY!!
        val rightX = instance.areaX!! + instance.machine!!.sizeX!!
        val bottomY = instance.areaY!! + instance.machine!!.sizeY!!
        return  leftX >= 0 || rightX < 1000 || topY >= 0 || bottomY < 1000 ||
                allInstances.stream().anyMatch {
                    instance != it
                            && (
                                it.areaX in leftX until rightX ||
                                        leftX in it.areaX!! until it.areaX!! + it.machine!!.sizeX!!
                            ) && (
                                it.areaY in topY until bottomY ||
                                        topY in it.areaY!! until it.areaY!! + it.machine!!.sizeY!!
                            )
                }
    }
}