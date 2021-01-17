package ru.itmo.db.coursework.orm.entity

import ru.itmo.db.coursework.orm.entity.id.CircuitBoardInstanceEntityId
import javax.persistence.*


@Entity
@Table(name = "circuit_board_instance")
@IdClass(CircuitBoardInstanceEntityId::class)
data class CircuitBoardInstanceEntity (
        @Id
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "user_id", referencedColumnName = "id")
        var user: UserEntity? = null,

        @Id
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "model_id", referencedColumnName = "id")
        var model: CircuitBoardEntity? = null,

        @Column(name = "amount", nullable = false)
        var amount: Int? = null
)
