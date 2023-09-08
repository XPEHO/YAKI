import { PasswordChangeDtoIn } from "./passwordChange.dtoIn";
import { PasswordRepository } from "./password.repository";
import { PasswordForgottenDtoIn } from "./passwordForgotten.dtoIn";

export class PasswordService {
  private passwordRespository: PasswordRepository;

  constructor(passwordRespository: PasswordRepository) {
    this.passwordRespository = passwordRespository;
  }

  async changePassword(passwordChange: PasswordChangeDtoIn): Promise<void> {
    this.passwordRespository.changePassword(passwordChange);
  }

  /**
   * Reset a user's password in the database
   * @param user user data coming from the mobile app
   * @returns True if the password was reset successfully, false otherwise
   * @throws Error if the password reset failed
   * @throws TypeError if the user data is incorrect
   */
  async forgotPassword(
    passwordForgotten: PasswordForgottenDtoIn
  ): Promise<void> {
    await this.passwordRespository.forgotPassword(passwordForgotten);
  }
}
