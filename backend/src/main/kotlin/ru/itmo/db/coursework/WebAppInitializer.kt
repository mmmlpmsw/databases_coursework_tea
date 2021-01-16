package ru.itmo.db.coursework

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer
import org.springframework.web.WebApplicationInitializer
import org.springframework.web.context.ContextLoaderListener
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext
import org.springframework.web.context.support.GenericWebApplicationContext
import org.springframework.web.servlet.DispatcherServlet
import javax.servlet.ServletContext

class WebAppInitializer : WebApplicationInitializer, AbstractSecurityWebApplicationInitializer(AppConfig::class.java)