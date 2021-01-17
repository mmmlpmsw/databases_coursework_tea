package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.orm.mapping.CircuitBoardEntityMapper
import ru.itmo.db.coursework.orm.repository.CircuitBoardRepository

@Service
class CircuitBoardOrmService @Autowired constructor(
    private val circuitBoardRepository: CircuitBoardRepository,
    private val circuitBoardEntityMapper: CircuitBoardEntityMapper
) {
    fun getAll() = circuitBoardRepository.findAll().map(circuitBoardEntityMapper::fromEntity)
}