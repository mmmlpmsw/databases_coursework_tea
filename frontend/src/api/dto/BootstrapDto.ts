import UserDto from "$src/api/dto/UserDto";
import MachineDto from "$src/api/dto/MachineDto";
import TeaDto from "$src/api/dto/TeaDto";
import CircuitBoard from "$src/game/model/CircuitBoard";
import MachineInstanceDto from "$src/api/dto/MachineInstanceDto";
import TeaInstanceDto from "$src/api/dto/TeaInstanceDto";
import CircuitBoardInstanceDto from "$src/api/dto/CircuitBoardInstanceDto";
import CircuitBoardDto from "$src/api/dto/CircuitBoardDto";

export default class BootstrapDto {
  constructor(
    public current_user: UserDto,
    public machines: MachineDto[],
    public teas: TeaDto[],
    public circuit_boards: CircuitBoardDto[],
    public machine_instances: MachineInstanceDto[],
    public tea_instances: TeaInstanceDto[],
    public circuit_board_instances: CircuitBoardInstanceDto[]
  ) {}
}