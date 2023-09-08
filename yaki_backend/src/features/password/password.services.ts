import { PasswordRepository } from "./password.repository";
import { PasswordForgottenDtoIn } from "./passwordForgotten.dtoIn";

export class PasswordService {
  private passwordRespository: PasswordRepository;

  constructor(passwordRespository: PasswordRepository) {
    this.passwordRespository = passwordRespository;
  }

  async forgotPassword(
    passwordForgotten: PasswordForgottenDtoIn
  ): Promise<void> {
    await this.passwordRespository.forgotPassword(passwordForgotten);
  }
}
