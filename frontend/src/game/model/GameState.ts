import User from "$src/game/model/User";
import Machine from "$src/game/model/Machine";
import Tea from "$src/game/model/Tea";
import CircuitBoard from "$src/game/model/CircuitBoard";
import MachineInstance from "$src/game/model/MachineInstance";
import TeaInstance from "$src/game/model/TeaInstance";
import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";

export default class GameState {
  public user: User = null;
  public game = {
    machines: {} as { [key:number]: Machine },
    teas: {} as { [key:number]: Tea },
    circuitBoards: {} as { [key:number]: CircuitBoard },
    machineInstances: {} as { [key:number]: MachineInstance },
    teaInstances: {} as { [key:number]: TeaInstance },
    circuitBoardInstances: {} as { [key:number]: CircuitBoardInstance }
  }
}