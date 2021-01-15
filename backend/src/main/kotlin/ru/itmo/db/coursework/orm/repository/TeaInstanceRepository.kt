package ru.itmo.db.coursework.orm.repository

import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository
import ru.itmo.db.coursework.orm.entity.TeaInstanceEntity
import ru.itmo.db.coursework.orm.entity.id.TeaInstanceEntityId

@Repository
interface TeaInstanceRepository : CrudRepository<TeaInstanceEntity, TeaInstanceEntityId>