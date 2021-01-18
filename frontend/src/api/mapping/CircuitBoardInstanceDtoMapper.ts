import TeaDto from "$src/api/dto/TeaDto";
import Tea from "$src/game/model/Tea";
import CircuitBoardInstanceDto from "$src/api/dto/CircuitBoardInstanceDto";
import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";

export default class CircuitBoardInstanceDtoMapper {
  public static fromDto(dto: CircuitBoardInstanceDto) {
    return new CircuitBoardInstance(dto.model_id, dto.amount)
  }

  public static toDto(model: CircuitBoardInstance) {
    return new CircuitBoardInstanceDto(model.modelId, model.amount)
  }
}