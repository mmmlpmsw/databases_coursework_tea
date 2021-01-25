export default class MachineInstance {
  constructor(
    public id: number,
    public machineId: number,
    public areaX: number,
    public areaY: number,
    public currentRecipeId: number,
    public currentRecipeIdCompletionTime: number
  ) {}
}