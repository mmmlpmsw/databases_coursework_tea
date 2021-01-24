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

    @Transactional
    @Procedure(procedureName = "buy_machine")
    /**
     * Сhecks whether the user has enough money to buy this machine.
     * If it is enough, it will be inserted into the table
     * and the amount of the user's money will be reduced.
     * There is no check for coordinates here, it will be performed in Spring.
     * !!! Call the function only if this check has passed !!!
     */
    fun buyMachine(userId: Int, machineId: Int, x: Int, y: Int): Boolean
}