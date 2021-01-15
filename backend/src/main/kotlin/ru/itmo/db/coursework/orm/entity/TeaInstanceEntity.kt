package ru.itmo.db.coursework.orm.entity

import ru.itmo.db.coursework.orm.entity.id.TeaInstanceEntityId
import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "tea_instance")
@IdClass(TeaInstanceEntityId::class)
data class TeaInstanceEntity (
        @Id
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "user_id")
        var user: UserEntity? = null,

        @Id
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "tea_id")
        var tea: TeaEntity? = null,

        @Column(name = "amount", nullable = false)
        var amount: Int? = null
): Serializable