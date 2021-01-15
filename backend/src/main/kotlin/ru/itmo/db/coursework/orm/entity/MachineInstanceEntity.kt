package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "machine_instance")
data class MachineInstanceEntity (
        @Id
        @Column(name = "id")
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "user_id", referencedColumnName = "id")
        var userId: UserEntity? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "machine_id", referencedColumnName = "id")
        var machineId: MachineEntity? = null,

        @Column(name = "area_x", nullable = false)
        var areaX: Int? = null,

        @Column(name = "area_y", nullable = false)
        var areaY: Int? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "current_recipe_id", referencedColumnName = "id")
        var currentRecipeId: MachineRecipeEntity? = null,

        @Column(name = "current_recipe_completion_time", nullable = true)
        var currentRecipeCompletionTime: Long? = null
)
