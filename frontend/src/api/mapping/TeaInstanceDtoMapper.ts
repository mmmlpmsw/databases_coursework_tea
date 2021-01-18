import TeaDto from "$src/api/dto/TeaDto";
import Tea from "$src/game/model/Tea";
import CircuitBoardInstanceDto from "$src/api/dto/CircuitBoardInstanceDto";
import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";
import TeaInstanceDto from "$src/api/dto/TeaInstanceDto";
import TeaInstance from "$src/game/model/TeaInstance";

export default class TeaInstanceDtoMapper {
  public static fromDto(dto: TeaInstanceDto) {
    return new TeaInstance(dto.tea_id, dto.amount)
  }

  public static toDto(model: TeaInstance) {
    return new TeaInstanceDto(model.teaId, model.amount)
  }
}