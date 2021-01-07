package ru.itmo.db.coursework

import org.springframework.web.WebApplicationInitializer
import org.springframework.web.context.ContextLoaderListener
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext
import org.springframework.web.context.support.GenericWebApplicationContext
import org.springframework.web.servlet.DispatcherServlet
import javax.servlet.ServletContext

class WebAppInitializer : WebApplicationInitializer {
    override fun onStartup(container: ServletContext) {
        val context = AnnotationConfigWebApplicationContext()
        context.register(AppConfig::class.java)
        container.addListener(ContextLoaderListener(context))
        val appServlet = container.addServlet("dispatcher", DispatcherServlet(GenericWebApplicationContext()))
        appServlet.setLoadOnStartup(1)
        appServlet.addMapping("/")
    }
}