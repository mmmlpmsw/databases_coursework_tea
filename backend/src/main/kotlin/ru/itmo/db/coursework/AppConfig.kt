package ru.itmo.db.coursework

import org.springframework.context.annotation.ComponentScan
import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.config.annotation.EnableWebMvc

@EnableWebMvc
@Configuration
@ComponentScan("ru.itmo.db.coursework")
open class AppConfig {

}