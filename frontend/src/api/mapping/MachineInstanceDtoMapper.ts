import TeaDto from "$src/api/dto/TeaDto";
import Tea from "$src/game/model/Tea";
import CircuitBoardInstanceDto from "$src/api/dto/CircuitBoardInstanceDto";
import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";
import TeaInstanceDto from "$src/api/dto/TeaInstanceDto";
import TeaInstance from "$src/game/model/TeaInstance";
import MachineInstanceDto from "$src/api/dto/MachineInstanceDto";
import MachineInstance from "$src/game/model/MachineInstance";

export default class MachineInstanceDtoMapper {
  public static fromDto(dto: MachineInstanceDto) {
    return new MachineInstance(dto.id, dto.machine_id, dto.area_x, dto.area_y, dto.current_recipe_id, dto.current_recipe_completion_time)
  }

  public static toDto(model: MachineInstance) {
    return new MachineInstanceDto(model.id, model.machineId, model.areaX, model.areaY, model.currentRecipeId, model.currentRecipeIdCompletionTime)
  }
}