import Machine from "$src/game/model/Machine";
import Tea from "$src/game/model/Tea";
import User from "$src/game/model/User";
import CircuitBoard from "$src/game/model/CircuitBoard";
import MachineInstance from "$src/game/model/MachineInstance";
import TeaInstance from "$src/game/model/TeaInstance";
import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";

export default class Bootstrap {
  constructor(
    public user: User,
    public machines: Machine[],
    public teas: Tea[],
    public circuitBoards: CircuitBoard[],
    public machineInstances: MachineInstance[],
    public teaInstances: TeaInstance[],
    public circuitBoardInstances: CircuitBoardInstance[]
  ) {}
}