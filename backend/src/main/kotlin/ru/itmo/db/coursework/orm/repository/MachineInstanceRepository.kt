package ru.itmo.db.coursework.orm.repository

import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.query.Procedure
import org.springframework.data.repository.CrudRepository
import ru.itmo.db.coursework.orm.entity.MachineInstanceEntity
import javax.transaction.Transactional

interface MachineInstanceRepository: CrudRepository<MachineInstanceEntity, Int> {
    fun findAllByUserId(userId: Int): List<MachineInstanceEntity>

    @Modifying
    @Transactional
    @Procedure(procedureName = "update_machine_instance_coordinates")
    fun setInstancePosition(instanceId: Int, x: Int, y: Int)
}