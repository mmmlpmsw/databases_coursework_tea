import MachineRecipe from "$src/game/model/MachineRecipe";

export default class Machine {
  constructor(
    public id: number,
    public name: string,
    public sizeX: number,
    public sizeY: number,
    public price: number,
    public recipes: MachineRecipe[]
  ) {}
}