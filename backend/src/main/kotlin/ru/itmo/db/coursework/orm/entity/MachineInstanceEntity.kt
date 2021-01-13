package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "machine_instance")
data class MachineInstanceEntity (
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(referencedColumnName = "id")
        var userId: UserEntity? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(referencedColumnName = "id")
        var machineId: MachineEntity? = null,

        @Column(nullable = false)
        var areaX: Int? = null,

        @Column(nullable = false)
        var areaY: Int? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(referencedColumnName = "id")
        var currentRecipeId: MachineRecipeEntity? = null,

        @Column(nullable = true)
        var currentRecipeCompletionTime: Long? = null
)
