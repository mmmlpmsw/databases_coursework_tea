package ru.itmo.db.coursework.orm.repository

import org.springframework.data.repository.CrudRepository
import ru.itmo.db.coursework.orm.entity.CircuitBoardEntity

interface CircuitBoardRepository : CrudRepository<CircuitBoardEntity, Int>