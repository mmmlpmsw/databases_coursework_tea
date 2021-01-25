package ru.itmo.db.coursework.orm.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ru.itmo.db.coursework.model.MachineInstance
import ru.itmo.db.coursework.model.TeaInstance
import ru.itmo.db.coursework.orm.entity.MachineInstanceEntity
import ru.itmo.db.coursework.orm.entity.TeaInstanceEntity
import ru.itmo.db.coursework.orm.mapping.TeaInstanceEntityMapper
import ru.itmo.db.coursework.orm.repository.TeaInstanceRepository

@Service
class TeaInstanceOrmService @Autowired constructor(
    private val teaInstanceRepository: TeaInstanceRepository,
    private val teaInstanceEntityMapper: TeaInstanceEntityMapper
) {
    fun getAllByUser(userId: Int) =
        teaInstanceRepository
            .findAllByUserId(userId)
            .map(teaInstanceEntityMapper::fromEntity)

    fun save(instance: TeaInstance, userId: Int): TeaInstanceEntity =
            teaInstanceRepository.save(teaInstanceEntityMapper.toEntity(instance, userId))
}