package ru.itmo.db.coursework.orm.repository

import org.springframework.data.jpa.repository.query.Procedure
import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import ru.itmo.db.coursework.orm.entity.TeaEntity

@Repository
interface TeaRepository : CrudRepository<TeaEntity, Int> {
    @Procedure(procedureName = "buy_tea")
    @Transactional
    fun buyTea(userId: Int, teaId: Int, amount: Int): Boolean
}