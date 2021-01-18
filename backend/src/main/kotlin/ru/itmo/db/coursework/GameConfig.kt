package ru.itmo.db.coursework

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import ru.itmo.db.coursework.model.MachineInstance

@Configuration
open class GameConfig {
    @Bean
    open fun defaultRegistrationMoney(): Long = 100

    @Bean
    open fun defaultRegistrationMachines(): Set<MachineInstance>  =
            setOf(MachineInstance(
                id = 1,
                machineId = 1,
                areaX = 0,
                areaY = 0
        ))

}