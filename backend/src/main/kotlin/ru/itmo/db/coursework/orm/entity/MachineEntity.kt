package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "machine")
data class MachineEntity (
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(nullable = false)
        var name: String? = null,

        @Column(nullable = false)
        var sizeX: Int? = null,

        @Column(nullable = false)
        var sizeY: Int? = null,

        @Column(nullable = false)
        var price: Long? = null,

        @OneToMany(
                targetEntity = MachineRecipeEntity::class,
                cascade = [CascadeType.ALL],
                fetch = FetchType.EAGER,
                mappedBy = "machine_id"
        )
        var recipies: Set<MachineRecipeEntity>? = null
)