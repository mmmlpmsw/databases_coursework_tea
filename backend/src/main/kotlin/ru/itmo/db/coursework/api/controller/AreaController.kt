package ru.itmo.db.coursework.api.controller

import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/area")
class AreaController {
    @PutMapping
    fun buyAndPlaceAreaThing() {
        // todo buy and place new area thing
    }

    @PostMapping
    fun updateAreaThing() {
        // todo update properties (x, y, etc.) of area thing
    }

    @DeleteMapping
    fun removeAreaThing() {
        // todo remove area thing
    }
}