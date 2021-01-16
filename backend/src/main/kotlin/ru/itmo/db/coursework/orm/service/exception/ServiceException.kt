package ru.itmo.db.coursework.orm.service.exception

/**
 * Бросается, когда возникла проблема в сервис-уровне
 */
class ServiceException(override val message: String) : RuntimeException(message)