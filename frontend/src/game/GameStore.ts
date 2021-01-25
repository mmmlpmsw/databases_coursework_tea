import Vuex, {Store} from "vuex";
import Bootstrap from "$src/game/model/Bootstrap";
import GameState from "$src/game/model/GameState";
import MachineInstance from "$src/game/model/MachineInstance";

export default function createGameStore(): Store<GameState> {
  return new Vuex.Store({
    state: new GameState(),
    mutations: {
      doBootstrap(state: GameState, bootstrap: Bootstrap) {
        function makeIdMap<T>(iterable: Array<T>, idExtractor: (T) => number): { [key:number]: T } {
          return Object.fromEntries(iterable.map(m => [idExtractor(m), m]));
        }

        state.user = bootstrap.user;
        state.game.machines = makeIdMap(bootstrap.machines, o => o.id);
        state.game.teas = makeIdMap(bootstrap.teas, o => o.id);
        state.game.circuitBoards = makeIdMap(bootstrap.circuitBoards, o => o.id);
        state.game.machineInstances = makeIdMap(bootstrap.machineInstances, o => o.id);
        state.game.teaInstances = makeIdMap(bootstrap.teaInstances, o => o.teaId);
        state.game.circuitBoardInstances = makeIdMap(bootstrap.circuitBoardInstances, o => o.modelId);
      },
      setMachineInstancePosition(state: GameState, data: {instanceId: number, x: number, y: number}) {
        state.game.machineInstances[data.instanceId].areaX = data.x;
        state.game.machineInstances[data.instanceId].areaY = data.y;
      },
      removeMachineInstance(state: GameState, instanceId: number) {
        delete state.game.machineInstances[instanceId]
      },
      addUserMoney(state: GameState, amount: number) {
        state.user.money += amount;
      },
      addMachineInstance(state: GameState, instance: MachineInstance) {
        state.game.machineInstances[instance.id] = instance;
      }
    }
  })
}