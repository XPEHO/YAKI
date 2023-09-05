import {PasswordChangeDtoIn} from "./passwordChange.dtoIn";
import "dotenv/config";

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
}
