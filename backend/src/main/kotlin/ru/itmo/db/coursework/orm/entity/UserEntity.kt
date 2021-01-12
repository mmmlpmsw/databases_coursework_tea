package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "user")
data class UserEntity (
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        var id: Int? = null,

        @Column(unique = true, nullable = false)
        var login: String? = null,

        @Column(nullable = false)
        var name: String? = null,

        @Column(name = "password_hash", nullable = false)
        var passwordHash: String? = null,

        var money: Long = 0
)