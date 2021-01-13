package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "circuit_board")
data class CircuitBoardEntity (
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(nullable = false)
        var name: String? = null,

        @Column(nullable = false)
        var sellPrice: Long? = null
)