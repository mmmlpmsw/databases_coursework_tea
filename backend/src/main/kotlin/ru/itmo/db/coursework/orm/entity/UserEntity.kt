package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "\"user\"")
data class UserEntity (
        @Id
        @Column(name = "id")
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(name = "login", unique = true, nullable = false)
        var login: String? = null,

        @Column(name = "name", nullable = false)
        var name: String? = null,

        @Column(name = "password_hash", nullable = false)
        var passwordHash: String? = null,

        @Column(name = "money")
        var money: Long = 0
)