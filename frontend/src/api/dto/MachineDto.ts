import MachineRecipeDto from "$src/api/dto/MachineRecipeDto";

export default class MachineDto {
  constructor(
    public id: number,
    public name: string,
    public size_x: number,
    public size_y: number,
    public price: number,
    public recipes: MachineRecipeDto[]
  ) {}
}