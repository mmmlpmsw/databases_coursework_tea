package ru.itmo.db.coursework.orm.entity

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "machine_recipe_tea")
data class MachineRecipeTeaEntity(
        @Id
        @Column(name = "machine_recipe_id")
        var machineRecipeId: Int? = null,

        @Id
        @ManyToOne
        @JoinColumn(name = "tea_id")
        var tea: TeaEntity? = null,

        @Column(name = "amount", nullable = false)
        var amount: Int? = null
): Serializable