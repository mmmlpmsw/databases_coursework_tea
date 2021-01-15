package ru.itmo.db.coursework.orm.repository

import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository
import ru.itmo.db.coursework.orm.entity.MachineEntity

@Repository
interface MachineRepository : CrudRepository<MachineEntity, Int>