package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "circuit_board")
data class CircuitBoardEntity (
        @Id
        @Column(name = "id")
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(name = "name", nullable = false)
        var name: String? = null,

        @Column(name = "sell_price", nullable = false)
        var sellPrice: Long? = null
)