package ru.itmo.db.coursework.orm.service

import org.hibernate.service.spi.ServiceException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import ru.itmo.db.coursework.model.MachineInstance
import ru.itmo.db.coursework.orm.entity.MachineInstanceEntity
import ru.itmo.db.coursework.orm.mapping.MachineInstanceEntityMapper
import ru.itmo.db.coursework.orm.repository.MachineInstanceRepository
import java.util.stream.Collectors

@Service
class MachineInstanceOrmService @Autowired constructor(
        private val machineInstanceRepository: MachineInstanceRepository,
        private val machineInstanceEntityMapper: MachineInstanceEntityMapper,
        private val teaInstanceOrmService: TeaInstanceOrmService
) {
    fun getAllByUser(userId: Int) =
        machineInstanceRepository
            .findAllByUserId(userId)
            .map(machineInstanceEntityMapper::fromEntity)

    fun add(instance: MachineInstance, userId: Int): MachineInstanceEntity =
        machineInstanceRepository.save(machineInstanceEntityMapper.toEntity(instance, userId))

    fun addAll(instances: MutableIterable<MachineInstance>, userId: Int): MutableIterable<MachineInstanceEntity> =
        machineInstanceRepository.saveAll(instances.map { machineInstanceEntityMapper.toEntity(it, userId) })

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

    @Transactional
    fun produceCircuitBoardInstance(userId: Int, instanceId: Int, recipeId: Int) {
        val instance = machineInstanceRepository.findById(instanceId)
                .orElseThrow{ ServiceException("no_such_machine_instance") }
        if (instance.currentRecipe != null)
            throw ServiceException("machine_in_use")
        val userTeas = teaInstanceOrmService.getAllByUser(userId).stream()
            .collect(Collectors.toMap({ it.teaId }, { it.amount }))

        if (
            instance.machine!!.recipes
            .stream()
            .filter { it.id == recipeId }
            .findFirst().get().teas
            .stream().allMatch {
                userTeas.containsKey(it?.tea?.id) && userTeas[it?.tea?.id]!! >= it?.amount!!
            }
        )
            machineInstanceRepository.produceCircuitBoardInstance(userId, instanceId, recipeId)
        else
            throw ServiceException("not_enough_teas")
    }
}