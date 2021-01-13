package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "tea")
data class TeaEntity(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(nullable = false)
        var name: String? = null,

        @Column(nullable = false)
        var price: Long? = null,

        @Column(nullable = false)
        var description: String? = null
)
