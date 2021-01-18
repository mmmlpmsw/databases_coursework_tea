export default class MachineRecipeDto {
  constructor(
    public id: number,
    public circuit_board_id: number,
    public circuit_board_amount: number,
    public work_time: number,
    public price: number,
    public teas: { [key: number]: number }
  ) {}
}