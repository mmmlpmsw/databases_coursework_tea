import TeaDto from "$src/api/dto/TeaDto";
import Tea from "$src/game/model/Tea";
import MachineDto from "$src/api/dto/MachineDto";
import Machine from "$src/game/model/Machine";
import MachineRecipeDtoMapper from "$src/api/mapping/MachineRecipeDtoMapper";

export default class MachineDtoMapper {
  public static fromDto(dto: MachineDto) {
    return new Machine(dto.id, dto.name, dto.size_x, dto.size_y, dto.price, dto.recipes.map(MachineRecipeDtoMapper.fromDto))
  }

  public static toDto(model: Machine) {
    return new MachineDto(model.id, model.name, model.sizeX, model.sizeY, model.price, model.recipes.map(MachineRecipeDtoMapper.toDto))
  }
}