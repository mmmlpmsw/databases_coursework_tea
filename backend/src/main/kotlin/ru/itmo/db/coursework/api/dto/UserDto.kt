package ru.itmo.db.coursework.api.dto

data class UserDto (
        var id: Int,
        var login: String,
        var name: String,
        var money: Long
)