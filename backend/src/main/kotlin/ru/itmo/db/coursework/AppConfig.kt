package ru.itmo.db.coursework

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.ComponentScan
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.PropertySource
import org.springframework.core.env.Environment
import org.springframework.core.env.StandardEnvironment
import org.springframework.web.servlet.config.annotation.EnableWebMvc

@EnableWebMvc
@Configuration
@PropertySource("classpath:app.properties")
@ComponentScan("ru.itmo.db.coursework")
open class AppConfig {
    @Autowired
    val env: Environment = StandardEnvironment()


}