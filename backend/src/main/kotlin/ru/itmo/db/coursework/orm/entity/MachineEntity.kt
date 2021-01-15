package ru.itmo.db.coursework.orm.entity

import org.hibernate.annotations.Cache
import org.hibernate.annotations.CacheConcurrencyStrategy
import javax.persistence.*

@Entity
@Table(name = "machine")
data class MachineEntity (
        @Id
        @Column(name = "id")
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Column(name = "name", nullable = false)
        var name: String? = null,

        @Column(name = "size_x", nullable = false)
        var sizeX: Int? = null,

        @Column(name = "size_y", nullable = false)
        var sizeY: Int? = null,

        @Column(name = "price", nullable = false)
        var price: Long? = null,

        @OneToMany(fetch = FetchType.EAGER)
        @JoinColumn(name = "machine_id")
        var recipes: Set<MachineRecipeEntity> = emptySet()
)