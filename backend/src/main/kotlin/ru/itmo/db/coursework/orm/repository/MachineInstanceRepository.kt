package ru.itmo.db.coursework.orm.repository

import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import ru.itmo.db.coursework.orm.entity.MachineInstanceEntity
import javax.transaction.Transactional

interface MachineInstanceRepository: CrudRepository<MachineInstanceEntity, Int> {
    fun findAllByUserId(userId: Int): List<MachineInstanceEntity>

    @Modifying
    @Transactional
    @Query("update machine_instance set area_x=:x, area_y=:y where id=:instanceId", nativeQuery = true)
    fun setInstancePosition(instanceId: Int, x: Int, y: Int) // todo заменить native query на процедуру
}