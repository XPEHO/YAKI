import {PasswordChangeDtoIn} from "./passwordChange.dtoIn";
import {PasswordRepository} from "./password.repository";
import YakiUtils from "../../utils/yakiUtils";

export class PasswordService {
  private passwordRespository: PasswordRepository;

  constructor(passwordRespository: PasswordRepository) {
    this.passwordRespository = passwordRespository;
  }

  async changePassword(passwordChange: PasswordChangeDtoIn): Promise<void> {
    // if same object structure verification
    const reference = new PasswordChangeDtoIn(0, "", "");
    if (YakiUtils.isSameObjStructure(passwordChange, reference) === false) {
      throw new TypeError("Incorrect data");
    }
    // if somes attributes are empty
    const isSomesAttributesEmpty = Object.values(passwordChange).some((value) => !value && value.trim() === "");
    if (isSomesAttributesEmpty === true) {
      throw new Error("Missing password change information(s)");
    }

    try {
      this.passwordRespository.changePassword(passwordChange);
    } catch (error: any) {
      throw new Error(error.message);
    }
  }
}
