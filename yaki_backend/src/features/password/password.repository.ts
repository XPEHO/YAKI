import {PasswordChangeDtoIn} from "./passwordChange.dtoIn";
import "dotenv/config";
import { PasswordForgottenDtoIn } from "./passwordForgotten.dtoIn";

export class PasswordRepository {
  async changePassword(passwordChange: PasswordChangeDtoIn): Promise<void> {
    try {
      fetch(`${process.env.ADMIN_API}/users/change-password`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(passwordChange),
      });
    } catch (error) {
      console.warn(error);
      throw error;
    }
  }
    async forgotPassword(
      passwordForgotten: PasswordForgottenDtoIn
    ): Promise<void> {
      fetch(`${process.env.ADMIN_API}/login/forgot-password`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(passwordForgotten),
      });
    }
  }