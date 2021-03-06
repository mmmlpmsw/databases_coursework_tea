package ru.itmo.db.coursework.orm.service

import org.hibernate.service.spi.ServiceException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.orm.mapping.TeaEntityMapper
import ru.itmo.db.coursework.orm.repository.TeaRepository

@Service
class TeaOrmService @Autowired constructor(
    private val teaRepository: TeaRepository,
    private val teaEntityMapper: TeaEntityMapper
) {
    fun getAll() = teaRepository.findAll().map(teaEntityMapper::fromEntity)
    fun buyTea(userId: Int, teaId: Int, amount: Int) {
        if (!teaRepository.buyTea(userId, teaId, amount))
            throw ServiceException("not_enough_money")
    }
}