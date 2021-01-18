import AreaThing from "$src/game/area/thing/AreaThing";
import MachineInstance from "$src/game/model/MachineInstance";
import {Store} from "vuex";
import GameState from "$src/game/model/GameState";
import Machine from "$src/game/model/Machine";

export default class MachineAreaThing extends AreaThing {
  private model: Machine;
  constructor(private store: Store<GameState>, public instance: MachineInstance) {
    super(
      instance.areaX,
      instance.areaY,
      store.state.game.machines[instance.machineId].sizeX,
      store.state.game.machines[instance.machineId].sizeY
    );
    this.model = store.state.game.machines[instance.machineId];
  }
}