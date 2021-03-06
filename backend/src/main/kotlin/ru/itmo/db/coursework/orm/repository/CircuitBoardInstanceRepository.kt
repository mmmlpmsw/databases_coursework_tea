package ru.itmo.db.coursework.orm.repository

import org.springframework.data.jpa.repository.query.Procedure
import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository
import ru.itmo.db.coursework.orm.entity.CircuitBoardInstanceEntity
import ru.itmo.db.coursework.orm.entity.id.CircuitBoardInstanceEntityId

@Repository
interface CircuitBoardInstanceRepository: CrudRepository<CircuitBoardInstanceEntity, CircuitBoardInstanceEntityId> {
    fun findAllByUserId(userId: Int): List<CircuitBoardInstanceEntity>

    @Procedure(procedureName = "add_circuit_board_instance")
    fun addInstance(userId: Int, modelId: Int, amount: Int)
}