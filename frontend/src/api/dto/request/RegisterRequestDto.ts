export default class RegisterRequestDto {
  constructor(
    public login: string,
    public name: string,
    public password: string
  ) {}
}