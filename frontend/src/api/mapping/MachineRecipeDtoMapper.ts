import MachineRecipeDto from "$src/api/dto/MachineRecipeDto";
import MachineRecipe from "$src/game/model/MachineRecipe";

export default class MachineRecipeDtoMapper {
  public static fromDto(dto: MachineRecipeDto) {
    return new MachineRecipe(dto.id, dto.circuit_board_id, dto.circuit_board_amount, dto.work_time, dto.price, dto.teas)
  }

  public static toDto(model: MachineRecipe) {
    return new MachineRecipeDto(model.id, model.circuitBoardId, model.circuitBoardAmount, model.workTime, model.price, model.teas)
  }
}