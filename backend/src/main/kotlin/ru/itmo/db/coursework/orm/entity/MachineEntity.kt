package ru.itmo.db.coursework.orm.entity

import org.hibernate.annotations.Cache
import org.hibernate.annotations.CacheConcurrencyStrategy
import java.io.Serializable
import javax.persistence.*

@Entity
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
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

        @Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
        @OneToMany(fetch = FetchType.EAGER)
        @JoinColumn(name = "machine_id")
        var recipes: Set<MachineRecipeEntity> = emptySet()
): Serializable