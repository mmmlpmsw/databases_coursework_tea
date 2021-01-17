import MachineRecipe from "$src/game/model/MachineRecipe";

export default class Machine {
  id: number;
  name: string;
  sizeX: number;
  sizeY: number;
  price: number;
  recipes: MachineRecipe[]
}