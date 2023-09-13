import { PasswordRepository } from "./password.repository";
import { PasswordForgottenDtoIn } from "./passwordForgotten.dtoIn";
import YakiUtils from "../../utils/yakiUtils";
import { PasswordChangeDtoIn } from "./passwortChange.dtoIn";

export class PasswordService {
  private passwordRespository: PasswordRepository;

  constructor(passwordRespository: PasswordRepository) {
    this.passwordRespository = passwordRespository;
  }

  async changePassword(passwordChange: PasswordChangeDtoIn): Promise<boolean> {
    // if same object structure verification
    const reference = new PasswordChangeDtoIn(0, "", "");
    if (YakiUtils.isSameObjStructure(passwordChange, reference) === false) {
      throw new TypeError("Incorrect data");
    }
    // if somes attributes are empty
    const isSomesAttributesEmpty = Object.values(passwordChange).some(
      (value) => !value && value.trim() === ""
    );
    if (isSomesAttributesEmpty === true) {
      throw new Error("Missing password change information(s)");
    }
    try {
      const response = await this.passwordRespository.changePassword(
        passwordChange
      );
      if (response === 200) {
        return true;
      }
    } catch (error: any) {
      throw new Error(error.message);
    }
    return false;
  }

  async forgotPassword(
    passwordForgotten: PasswordForgottenDtoIn
  ): Promise<boolean> {
    const reference = new PasswordForgottenDtoIn("");
    if (YakiUtils.isSameObjStructure(passwordForgotten, reference) === false) {
      throw new TypeError("Incorrect data");
    }
    try {
      const response = await this.passwordRespository.forgotPassword(
        passwordForgotten
      );

      if (response === 200) {
        console.warn("service", response);
        return true;
      }
    } catch (error: any) {
      throw new Error(error.message);
    }
    return false;
  }
}
