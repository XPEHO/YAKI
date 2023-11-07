import {AvatarEnum} from "./avatar.enum";
import {UserRepository} from "./user.repository";
import {authService} from "./authentication.service";
import YakiUtils from "../../utils/yakiUtils";

import {TeammateDtoOut} from "../teammate/teammate.dtoOut";
import {CaptainDtoOut} from "../captain/captain.dtoOut";
import {UserToRegisterIn} from "./toRegister.dtoIn";
import {UserToRegisterOut} from "./toRegister.dtoOut";
import {RegisterResponse} from "./registerResponse";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";
import {LoginDtoIn} from "./login.dtoIn";

import fs from "fs";
import {AvatarDto} from "./avatar.dto";

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
  checkUserLoginDetails = async (loginUser: LoginDtoIn) => {
    const reference = new LoginDtoIn("", "");
    if (YakiUtils.isSameObjStructure(loginUser, reference) === false) {
      throw new TypeError("Incorrect data");
    }

    const searchUser = await this.userRepository.getByLogin(loginUser.login);

    if (await authService.comparePw(loginUser.password, searchUser.user_password)) {
      let user = undefined;
      // if captain_id column is null, create a team_mate
      if (searchUser.captain_id === null) {
        user = new TeammateDtoOut(
          searchUser.teammate_id,
          searchUser.user_id,
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
      console.log("Bad authentification details");
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
    try {
      const springResponse = await this.userRepository.registerUser(userToRegister);
      if (springResponse.id !== 0 && springResponse.id !== null) {
        responseAfterRegister.isRegistered = true;
      }
      return responseAfterRegister;
    } catch (error: any) {
      if (error instanceof EmailAlreadyExistsError) {
        throw new EmailAlreadyExistsError(error.message);
      } else {
        // catch server errors
        throw TypeError;
      }
    }
  };

  /**
   * Get user informations by his ID
   * @param userId
   * @returns
   */
  getUserById = async (userId: number) => {
    return await this.userRepository.getUserById(userId);
  };

  /**
   * Register a new avatar for a user.
   * It reads the avatar file buffer which is a binary data, it's used to save the image in the database as bytea.
   *
   * It checks if the avatar already exists in the database, if it does, it doesn't register it, but return avatar infos.
   * If not exist then calls the `registerNewAvatar` method on the `userRepository` to store the avatar.
   * @param userId : The ID of the user for whom the avatar is being registered.
   * @param file (Express.Multer.File): The avatar file that has been uploaded. This object includes various properties about the file, including its path on the server.
   * @param avatarReference The name of the avatar. This must be a value from the `AvatarEnum`.
   */
  registerNewAvatar = async (
    userId: number,
    file: Express.Multer.File,
    avatarReference: string
  ): Promise<AvatarDto> => {
    const avatarChoices: string[] = Object.values(AvatarEnum);
    if (!avatarChoices.includes(avatarReference)) {
      throw new TypeError(`${avatarReference} isn't an existing avatar choice`);
    }
    // get the file buffer (binary data)
    const fileData = fs.readFileSync(file.path);

    // Is the avatar already in the database ? (compare blob data)
    const isAvatarInDataBase: AvatarDto | null = await this.userRepository.isAvatarInDataBase(userId, avatarReference);

    if (isAvatarInDataBase !== null && isAvatarInDataBase.avatarReference === avatarReference) {
      if (isAvatarInDataBase.avatarBlob.toString("base64") === fileData.toString("base64")) {
        await this.userRepository.setAvatarChoiceInUser(userId, isAvatarInDataBase.avatarId);
        return isAvatarInDataBase;
      }
      const updatedAvatarRow = await this.userRepository.updateAvatarBlob(fileData, userId, avatarReference);
      return updatedAvatarRow;
    }

    // Else register the avatar in the database
    // if the avatar is the user picture, it needs to be validated by an admin
    let isValidated: boolean;
    // TODO: change first isValidated = true to = false this when the admin validation will be implemented
    avatarReference === AvatarEnum.USERPICTURE ? (isValidated = true) : (isValidated = true);
    const registeredAvatar: AvatarDto = await this.userRepository.registerNewAvatar(
      userId,
      avatarReference,
      fileData,
      isValidated
    );
    await this.userRepository.setAvatarChoiceInUser(userId, registeredAvatar.avatarId);

    return registeredAvatar;
  };
}
