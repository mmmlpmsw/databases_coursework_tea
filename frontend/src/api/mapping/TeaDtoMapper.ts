import TeaDto from "$src/api/dto/TeaDto";
import Tea from "$src/game/model/Tea";

export default class TeaDtoMapper {
  public static fromDto(dto: TeaDto) {
    return new Tea(dto.id, dto.name, dto.price, dto.description)
  }

  public static toDto(model: Tea) {
    return new TeaDto(model.id, model.name, model.price, model.description)
  }
}