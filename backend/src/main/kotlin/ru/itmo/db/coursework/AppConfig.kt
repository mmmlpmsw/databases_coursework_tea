package ru.itmo.db.coursework

import org.hibernate.jpa.HibernatePersistenceProvider
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.*
import org.springframework.core.env.Environment
import org.springframework.core.env.StandardEnvironment
import org.springframework.data.jpa.repository.config.EnableJpaRepositories
import org.springframework.jdbc.datasource.DriverManagerDataSource
import org.springframework.orm.jpa.JpaTransactionManager
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import java.util.*
import javax.sql.DataSource

@Import(WebSecurityConfig::class, GameConfig::class)
@EnableWebMvc
@Configuration
@PropertySource("classpath:app.properties")
@ComponentScan("ru.itmo.db.coursework")
@EnableJpaRepositories("ru.itmo.db.coursework")
open class AppConfig {
    @Autowired
    val env: Environment = StandardEnvironment()

    @Bean
    open fun dataSource(): DataSource {
        val dataSource = DriverManagerDataSource()
        dataSource.setDriverClassName(env.getRequiredProperty("db.driver"))
        dataSource.url = env.getRequiredProperty("db.url")
        dataSource.username = env.getRequiredProperty("db.username")
        dataSource.password = env.getRequiredProperty("db.password")
        return dataSource
    }

    @Bean
    open fun hibernateProperties(): Properties {
        val properties = Properties()
        properties["hibernate.jdbc.batch_size"] = "100"
        properties["hibernate.dialect"] = env.getRequiredProperty("db.hibernate.dialect")
        properties["hibernate.show_sql"] = env.getRequiredProperty("db.hibernate.show_sql")
        properties["hibernate.hbm2ddl.auto"] = env.getRequiredProperty("db.hibernate.hbm2ddl.auto")
        properties["hibernate.cache.provider_class"] = "org.hibernate.cache.EhCacheProvider"
        properties["hibernate.cache.region.factory_class"] = "org.hibernate.cache.ehcache.EhCacheRegionFactory"
        properties["hibernate.query.in_clause_parameter_padding"] = "true"
        properties["hibernate.cache.use_structured_entries"] = "true"
        properties["hibernate.cache.use_second_level_cache"] = "true"
        properties["hibernate.cache.use_query_cache"] = "true"
        return properties
    }

    @Bean
    open fun entityManagerFactory(): LocalContainerEntityManagerFactoryBean {
        val entityManagerFactoryBean = LocalContainerEntityManagerFactoryBean()
        entityManagerFactoryBean.dataSource = dataSource()
        entityManagerFactoryBean.setPersistenceProviderClass(HibernatePersistenceProvider::class.java)
        entityManagerFactoryBean.setPackagesToScan("ru.itmo.db.coursework")
        entityManagerFactoryBean.setJpaProperties(hibernateProperties())
        return entityManagerFactoryBean
    }

    @Bean
    open fun transactionManager(): JpaTransactionManager? {
        val transactionManager = JpaTransactionManager()
        transactionManager.entityManagerFactory = entityManagerFactory().getObject()
        return transactionManager
    }
}