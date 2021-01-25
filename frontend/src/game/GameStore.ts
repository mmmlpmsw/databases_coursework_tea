import Vuex, {Store} from "vuex";
import Bootstrap from "$src/game/model/Bootstrap";
import GameState from "$src/game/model/GameState";
import MachineInstance from "$src/game/model/MachineInstance";
import TeaInstance from "$src/game/model/TeaInstance";
import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";

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
      },
      buyTeaInstance(state: GameState, instance: TeaInstance) {
        let current = state.game.teaInstances[instance.teaId] || new TeaInstance(instance.teaId, 0);
        current.amount += instance.amount;
        state.game.teaInstances[instance.teaId] = current;
        state.user.money -= state.game.teas[instance.teaId].price * instance.amount;
      },
      addCircuitBoardInstance(state: GameState, instance: CircuitBoardInstance) {
        let current = state.game.circuitBoardInstances[instance.modelId] || new CircuitBoardInstance(instance.modelId, 0);
        current.amount += instance.amount;
        state.game.circuitBoardInstances[instance.modelId] = current;
      },
      spendTeaInstance(state: GameState, instance: TeaInstance) {
        state.game.teaInstances[instance.teaId].amount -= instance.amount;
      },
      setMachineInstanceCurrentRecipeId(state: GameState, data: { instanceId: number, recipeId: number, completionTime: number }) {
        state.game.machineInstances[data.instanceId].currentRecipeId = data.recipeId;
        state.game.machineInstances[data.instanceId].currentRecipeIdCompletionTime = data.completionTime;
      }
    }
  })
}