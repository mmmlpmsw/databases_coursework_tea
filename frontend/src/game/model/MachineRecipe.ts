export default class MachineRecipe {
  constructor(
    public id: number,
    public circuitBoardId: number,
    public circuitBoardAmount: number,
    public workTime: number,
    public price: number,
    public teas: { [key: number]: number }
  ) {}
}