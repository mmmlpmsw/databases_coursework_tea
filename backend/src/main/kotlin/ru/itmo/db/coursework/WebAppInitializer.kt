package ru.itmo.db.coursework

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer
import org.springframework.web.context.ContextLoaderListener
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext
import org.springframework.web.servlet.DispatcherServlet
import javax.servlet.ServletContext

class WebAppInitializer : AbstractSecurityWebApplicationInitializer() {
    override fun beforeSpringSecurityFilterChain(servletContext: ServletContext) {
        val appContext = AnnotationConfigWebApplicationContext()
        appContext.register(AppConfig::class.java)
        servletContext.addListener(ContextLoaderListener(appContext))
        val appServlet = servletContext.addServlet("servlet", DispatcherServlet(appContext))
        appServlet.setLoadOnStartup(1)
        appServlet.addMapping("/")
    }
}