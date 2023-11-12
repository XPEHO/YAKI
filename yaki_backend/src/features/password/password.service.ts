import {UserService} from "./../user/user.service";
import {PasswordRepository} from "./password.repository";
import {PasswordForgottenDtoIn} from "./passwordForgotten.dtoIn";
import YakiUtils from "../../utils/yakiUtils";
import bcrypt from "bcrypt";
import {PasswordChangeDtoIn} from "./passwortChange.dtoIn";
import {DataError} from "../../errors/dataOrDataBaseError";

export class PasswordService {
  private passwordRespository: PasswordRepository;
  private userService: UserService;

  constructor(passwordRespository: PasswordRepository, userService: UserService) {
    this.passwordRespository = passwordRespository;
    this.userService = userService;
  }

  async changePassword(passwordChange: PasswordChangeDtoIn): Promise<boolean> {
    // if same object structure verification
    const reference = new PasswordChangeDtoIn(0, "", "");
    if (YakiUtils.isSameObjStructure(passwordChange, reference) === false) {
      throw new DataError("Incorrect data");
    }
    // if somes attributes are empty
    const isSomesAttributesEmpty = Object.values(passwordChange).some((value) => !value && value.trim() === "");
    if (isSomesAttributesEmpty === true) {
      throw new DataError("Missing password change information(s)");
    }
    // error throw already handled in the getUserById method
    await this.userService.getUserById(passwordChange.userId);
    // error throw already handled in the getEncryptedUserPassword & verifyPassword method
    const userEncryptedPW: string = await this.getEncryptedUserPassword(passwordChange.userId);
    await this.verifyPassword(passwordChange.currentPassword, userEncryptedPW);

    try {
      const hashedNewPassword = await bcrypt.hash(passwordChange.newPassword, 16);
      const isPasswordChanged = await this.passwordRespository.changePassword(passwordChange.userId, hashedNewPassword);
      return isPasswordChanged;
    } catch (error: any) {
      throw error;
    }
  }

  /**
   * Retrive the encrypted password of the user
   * @param userId
   * @returns {Promise<string>} - The encrypted password of the user.
   */
  async getEncryptedUserPassword(userId: number): Promise<string> {
    try {
      const userEncryptedPassword = await this.passwordRespository.getUserEncryptedPassword(userId);

      return userEncryptedPassword;
    } catch (error: any) {
      console.error(error);
      throw error;
    }
  }

  /**
   * Verifies if the provided password matches the encrypted password in the database.
   *
   * @param sentCurrentPw The password provided by the user.
   * @param dbcurrentEncryptedPW The encrypted password stored in the database.
   * @returns A boolean indicating whether the provided password matches the encrypted password.
   * @throws {Error} If the provided password does not match the encrypted password.
   */
  async verifyPassword(sentCurrentPw: string, dbcurrentEncryptedPW: string): Promise<boolean> {
    try {
      const isPasswordMatch: boolean = await bcrypt.compare(sentCurrentPw, dbcurrentEncryptedPW);

      if (!isPasswordMatch) {
        throw new DataError("Your current password do not match");
      }
      return true;
    } catch (error: any) {
      console.error(error);
      throw error;
    }
  }

  /**
   * This method handles the forgotten password process.
   *
   * @param {PasswordForgottenDtoIn} passwordForgotten - The data object containing the user's information for the forgotten password process.
   * @returns {Promise<boolean>} - Returns`true` if the process was successful, and `false` otherwise.
   */
  async forgotPassword(passwordForgotten: PasswordForgottenDtoIn): Promise<boolean> {
    const reference = new PasswordForgottenDtoIn("");
    if (YakiUtils.isSameObjStructure(passwordForgotten, reference) === false) {
      throw new DataError("Incorrect data");
    }
    try {
      const response = await this.passwordRespository.forgotPassword(passwordForgotten);

      if (response === 200) {
        console.warn("service", response);
        return true;
      }
    } catch (error: any) {
      console.error(error);
      throw error;
    }
    return false;
  }
}
