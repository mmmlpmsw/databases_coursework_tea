package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "tea_instance")
data class TeaInstanceEntity (
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(referencedColumnName = "id")
        var userId: UserEntity? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(referencedColumnName = "id")
        var teaId: TeaEntity? = null,

        @Column(nullable = false)
        var amount: Int? = null
)