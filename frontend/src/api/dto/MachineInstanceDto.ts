export default class MachineInstanceDto {
  constructor(
    public id: number,
    public machine_id: number,
    public area_x: number,
    public area_y: number,
    public current_recipe_id: number,
    public current_recipe_completion_time: number
  ) {}
}