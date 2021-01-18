package ru.itmo.db.coursework

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import ru.itmo.db.coursework.model.MachineInstance

@Configuration
open class GameConfig {
    @Bean
    open fun defaultRegistrationMoney(): Long = 0 // todo решить, сколько денег дать при регистрации

    @Bean
    open fun defaultRegistrationMachines(): Set<MachineInstance> = setOf() // todo решить, сколько и какие машины дать при регистрации
}