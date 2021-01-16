package ru.itmo.db.coursework.model

data class User(
        var id: Int,
        var login: String,
        var name: String,
        var passwordHash: String,
        var money: Long
)
