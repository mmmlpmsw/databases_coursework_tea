import UserDto from "$src/api/dto/UserDto";
import User from "$src/game/model/User";
import CircuitBoard from "$src/game/model/CircuitBoard";
import CircuitBoardDto from "$src/api/dto/CircuitBoardDto";

export default class CircuitBoardDtoMapper {
  public static fromDto(dto: CircuitBoardDto) {
    return new CircuitBoard(dto.id, dto.name, dto.sell_price)
  }

  public static toDto(model: CircuitBoard) {
    return new CircuitBoardDto(model.id, model.name, model.sellPrice)
  }
}