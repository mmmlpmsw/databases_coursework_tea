package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "tea")
data class TeaEntity(
        @Id
        @Column(name = "id")
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(name = "name", nullable = false)
        var name: String? = null,

        @Column(name = "price", nullable = false)
        var price: Long? = null,

        @Column(name = "description", nullable = false)
        var description: String? = null
)
