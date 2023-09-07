import { PasswordChangeDtoIn } from "./passwordChange.dtoIn";
import { PasswordRepository } from "./password.repository";

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
  async forgotPassword(user: any): Promise<boolean> {
    try {
      const newPassword = await fetch(`${process.env.ADMIN_API}/gpamonpwd`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(user),
      });
      if (!newPassword.ok) {
        if (newPassword.status === 418)
          throw new Error("password reset failed");
      }
      let jsonResponse = await newPassword.json();
      return jsonResponse;
    } catch (err) {
      console.warn(err);
      throw err;
    }
  }
}

