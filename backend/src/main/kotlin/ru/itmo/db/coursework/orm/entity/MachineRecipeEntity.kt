package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "machine_recipe")
data class MachineRecipeEntity (
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(name = "machine_id")
        var machineId: Int? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "circuit_board_id")
        var circuitBoard: CircuitBoardEntity? = null,

        @Column(name = "circuit_board_amount", nullable = false)
        var circuitBoardAmount: Int? = null,

        @Column(name = "work_time", nullable = false)
        var workTime: Long? = null,

        @Column(name = "price", nullable = false)
        var price: Long? = null,

        @OneToMany
        @JoinColumn(name = "machine_recipe_id")
        var teas: Set<MachineRecipeTeaEntity> = emptySet()
)