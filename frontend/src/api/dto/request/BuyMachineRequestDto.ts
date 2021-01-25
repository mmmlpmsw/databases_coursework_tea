export default class BuyMachineRequestDto {
  constructor(
    public machine_id: number,
    public area_x: number,
    public area_y: number
  ) {}
}