import Vuex from "vuex";
import User from "$src/game/model/User";
import Machine from "$src/game/model/Machine";
import Tea from "$src/game/model/Tea";
import Bootstrap from "$src/game/model/Bootstrap";
import CircuitBoard from "$src/game/model/CircuitBoard";
import MachineInstance from "$src/game/model/MachineInstance";
import TeaInstance from "$src/game/model/TeaInstance";
import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";

export default function createGameStore() {
  return new Vuex.Store({
    state: {
      apiToken: null,
      game: {
        user: null as User,
        machines: [] as Machine[],
        teas: [] as Tea[],
        circuitBoards: [] as CircuitBoard[],
        machineInstances: [] as MachineInstance[],
        teaInstances: [] as TeaInstance[],
        circuitBoardInstances: [] as CircuitBoardInstance[]
      }
    },
    mutations: {
      setApiToken(state, token) {
        state.apiToken = token
      },
      doBootstrap(state, bootstrap: Bootstrap) {
        state.game.user = bootstrap.user;
        state.game.machines = bootstrap.machines;
        state.game.teas = bootstrap.teas;
        state.game.circuitBoards = bootstrap.circuitBoards;
        state.game.machineInstances = bootstrap.machineInstances;
        state.game.teaInstances = bootstrap.teaInstances;
        state.game.circuitBoardInstances = bootstrap.circuitBoardInstance;
      },
    }
  })
}