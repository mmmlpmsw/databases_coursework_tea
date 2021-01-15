package ru.itmo.db.coursework.orm.entity

import ru.itmo.db.coursework.orm.entity.id.CircuitBoardInstanceEntityId
import javax.persistence.*


@Entity
@Table(name = "circuit_board_instance")
@IdClass(CircuitBoardInstanceEntityId::class)
data class CircuitBoardInstanceEntity (
//        @Id
//        @Column(name = "id")
//        @GeneratedValue(strategy = GenerationType.IDENTITY)
//        var id: Int? = null,

        @Id
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "user_id", referencedColumnName = "id")
        var userId: UserEntity? = null,

        @Id
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "model_id", referencedColumnName = "id")
        var modelId: CircuitBoardEntity? = null,

        @Column(name = "amount", nullable = false)
        var amount: Int? = null
)
