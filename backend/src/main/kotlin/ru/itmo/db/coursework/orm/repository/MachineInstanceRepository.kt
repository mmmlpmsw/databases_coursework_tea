package ru.itmo.db.coursework.orm.repository

import org.springframework.data.repository.CrudRepository
import ru.itmo.db.coursework.orm.entity.MachineInstanceEntity

interface MachineInstanceRepository: CrudRepository<MachineInstanceEntity, Int> {
    fun findAllByUserId(userId: Int): List<MachineInstanceEntity>
}