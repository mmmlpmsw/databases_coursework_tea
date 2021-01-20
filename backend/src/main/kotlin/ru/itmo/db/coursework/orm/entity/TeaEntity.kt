package ru.itmo.db.coursework.orm.entity

import org.hibernate.annotations.Cache
import org.hibernate.annotations.CacheConcurrencyStrategy
import java.io.Serializable
import javax.persistence.*

@Entity
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
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
): Serializable
