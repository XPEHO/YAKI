import {UserRepository} from "./user.repository";
import {authService} from "./authentication.service";
import YakiUtils from "../../utils/yakiUtils";

import {TeamMateDtoOut} from "../teamMate/teamMate.dtoOut";
import {CaptainDtoOut} from "../captain/captain.dtoOut";
import {UserToRegisterIn} from "./toRegister.dtoIn";
import {UserToRegisterOut} from "./toRegister.dtoOut";
import {RegisterResponse} from "./registerResponse";

export class UserService {
  userRepository: UserRepository;

  constructor(repository: UserRepository) {
    this.userRepository = repository;
  }

  /**
   * Send the login and password to the repository and return a user if its found
   * @param object
   * @returns
   */
  checkUserLoginDetails = async (object: any) => {
    const searchUser = await this.userRepository.getByLogin(object.login);
    if (await authService.comparePw(object.password, searchUser.user_password)) {
      let user = undefined;
      // if captain_id column is null, create a team_mate
      if (searchUser.captain_id === null) {
        user = new TeamMateDtoOut(
          searchUser.team_mate_id,
          searchUser.user_id,
          searchUser.team_mate_team_id,
          searchUser.user_last_name,
          searchUser.user_first_name,
          searchUser.user_email
        );
      } else {
        // else create a captain
        user = new CaptainDtoOut(
          searchUser.captain_id,
          searchUser.user_id,
          searchUser.user_last_name,
          searchUser.user_first_name,
          searchUser.user_email
        );
      }
      // add a token to the user before sending to front
      return authService.createToken(user);
    } else {
      throw new Error("Bad authentification details");
    }
  };

  /**
   *
   * @param user user send from mobile app registration process
   * @returns response from admin api after email confirmation & successfull registration
   */
  registerUser = async (user: UserToRegisterIn): Promise<RegisterResponse> => {
    const responseAfterRegister = new RegisterResponse(false);

    const reference = new UserToRegisterIn("", "", "", "");
    if (YakiUtils.isSameObjStructure(user, reference) === false) {
      throw new TypeError("Incorrect data");
    }
    const isSomesAttributesEmpty = Object.values(user).some((value) => !value && value.trim() === "");
    if (isSomesAttributesEmpty === true) {
      throw new Error("Missing registration information(s)");
    }

    let userToRegister = new UserToRegisterOut(
      user.lastname.trim(),
      user.firstname.trim(),
      user.email.trim(),
      user.email.trim(),
      user.password.trim()
    );
      const springResponse = await this.userRepository.registerUser(userToRegister);
      if (springResponse.id !== 0 && springResponse.id !== null) {
        responseAfterRegister.isRegistered = true;
      }
      return responseAfterRegister;
  };
}
