import BootstrapDto from "$src/api/dto/BootstrapDto";
import Bootstrap from "$src/game/model/Bootstrap";
import UserDtoMapper from "$src/api/mapping/UserDtoMapper";
import MachineDtoMapper from "$src/api/mapping/MachineDtoMapper";
import TeaDtoMapper from "$src/api/mapping/TeaDtoMapper";
import CircuitBoardDtoMapper from "$src/api/mapping/CircuitBoardDtoMapper";
import MachineInstanceDtoMapper from "$src/api/mapping/MachineInstanceDtoMapper";
import TeaInstanceDtoMapper from "$src/api/mapping/TeaInstanceDtoMapper";
import CircuitBoardInstanceDtoMapper from "$src/api/mapping/CircuitBoardInstanceDtoMapper";

export default class BootstrapDtoMapper {
  public static fromDto(dto: BootstrapDto) {
    return new Bootstrap(
      UserDtoMapper.fromDto(dto.current_user),
      dto.machines.map(MachineDtoMapper.fromDto),
      dto.teas.map(TeaDtoMapper.fromDto),
      dto.circuit_boards.map(CircuitBoardDtoMapper.fromDto),
      dto.machine_instances.map(MachineInstanceDtoMapper.fromDto),
      dto.tea_instances.map(TeaInstanceDtoMapper.fromDto),
      dto.circuit_board_instances.map(CircuitBoardInstanceDtoMapper.fromDto)
    )
  }
}