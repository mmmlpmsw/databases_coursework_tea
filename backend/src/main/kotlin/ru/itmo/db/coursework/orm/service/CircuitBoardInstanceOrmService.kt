package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.orm.mapping.CircuitBoardInstanceEntityMapper
import ru.itmo.db.coursework.orm.repository.CircuitBoardInstanceRepository

@Service
class CircuitBoardInstanceOrmService @Autowired constructor(
    private val circuitBoardInstanceRepository: CircuitBoardInstanceRepository,
    private val circuitBoardInstanceEntityMapper: CircuitBoardInstanceEntityMapper
) {
    fun getAllByUser(userId: Int) =
        circuitBoardInstanceRepository.findAllByUserId(userId)
            .map(circuitBoardInstanceEntityMapper::fromEntity)

    fun addInstance(userId: Int, modelId: Int, amount: Int) {
        circuitBoardInstanceRepository.addInstance(userId, modelId, amount)
    }
}