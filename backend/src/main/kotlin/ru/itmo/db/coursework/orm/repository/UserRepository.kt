package ru.itmo.db.coursework.orm.repository

import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository
import ru.itmo.db.coursework.orm.entity.UserEntity
import java.util.*

@Repository
interface UserRepository : CrudRepository<UserEntity, Int> {
    fun findByLogin(login: String): Optional<UserEntity>
    fun existsByLogin(login: String): Boolean
}