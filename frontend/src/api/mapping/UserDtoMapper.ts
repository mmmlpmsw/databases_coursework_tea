import UserDto from "$src/api/dto/UserDto";
import User from "$src/game/model/User";

export default class UserDtoMapper {
  public static fromDto(dto: UserDto) {
    return new User(dto.id, dto.login, dto.name, dto.money)
  }

  public static toDto(model: User) {
    return new UserDto(model.id, model.login, model.name, model.money)
  }
}