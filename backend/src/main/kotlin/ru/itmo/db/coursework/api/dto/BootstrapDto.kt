package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class BootstrapDto(
        @JsonProperty("current_user")
        val currentUser: UserDto,
        val machines: List<MachineDto>,
        val teas: List<TeaDto>,
        @JsonProperty("circuit_boards")
        val circuitBoards: List<CircuitBoardDto>
        // todo machine instances
        // todo tea instances
        // todo citcuit board instances
)