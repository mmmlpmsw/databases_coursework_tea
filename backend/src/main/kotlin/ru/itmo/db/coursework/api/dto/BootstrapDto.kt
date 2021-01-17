package ru.itmo.db.coursework.api.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class BootstrapDto(
        @get:JsonProperty("current_user")
        val currentUser: UserDto,
        val machines: List<MachineDto>,
        val teas: List<TeaDto>,
        @get:JsonProperty("circuit_boards")
        val circuitBoards: List<CircuitBoardDto>,
        @get:JsonProperty("machine_instances")
        val machineInstances: List<MachineInstanceDto>,
        @get:JsonProperty("tea_instances")
        val teaInstances: List<TeaInstanceDto>,
        @get:JsonProperty("circuit_board_instances")
        val circuitBoardInstances: List<CircuitBoardInstanceDto>
)