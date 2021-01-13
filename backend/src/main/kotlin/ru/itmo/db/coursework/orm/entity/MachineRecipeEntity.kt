package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "machine_recipe")
data class MachineRecipeEntity (
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(referencedColumnName = "id")
        var circuitBoardId: CircuitBoardEntity? = null,

        @Column(nullable = false)
        var circuitBoardAmount: Int? = null,

        @Column(nullable = false)
        var workTime: Long? = null,

        @Column(nullable = false)
        var price: Long? = null
)