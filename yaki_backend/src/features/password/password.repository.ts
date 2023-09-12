import "dotenv/config";
import { PasswordForgottenDtoIn } from "./passwordForgotten.dtoIn";
import { PasswordChangeDtoIn } from "./passwortChange.dtoIn";

export class PasswordRepository {
  async changePassword(passwordChange: PasswordChangeDtoIn): Promise<number> {
    console.log("password repository, password change : ", passwordChange);
    try {
      const response = await fetch(
        `${process.env.ADMIN_API}/users/change-password`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(passwordChange),
        }
      );
      if (!response.ok) {
        throw new Error("Password change failed");
      } else {
        console.log("Password change success");
      }
      return response.status;
    } catch (error) {
      console.warn(error);
      throw error;
    }
  }

  async forgotPassword(
    passwordForgotten: PasswordForgottenDtoIn
  ): Promise<number> {
    try {
      const response = await fetch(
        `${process.env.ADMIN_API}/login/forgot-password`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(passwordForgotten),
        }
      );
      console.warn("repository res.status", response.status);
      return response.status;
    } catch (error) {
      console.warn(error);
      throw error;
    }
  }
}
