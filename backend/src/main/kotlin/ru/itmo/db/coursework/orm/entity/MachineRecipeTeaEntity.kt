package ru.itmo.db.coursework.orm.entity

import javax.persistence.*

@Entity
@Table(name = "machine_recipe_tea")
data class MachineRecipeTeaEntity(
        @Id
        @ManyToOne(targetEntity = MachineRecipeEntity::class)
        var machineRecipe: MachineRecipeEntity? = null,

        @Id
        @ManyToOne(targetEntity = TeaEntity::class)
        var tea: TeaEntity? = null,

        @Column(nullable = false)
        var amount: Int? = null
)
