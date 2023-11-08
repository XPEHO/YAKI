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
    if (userId === undefined || userId === null) {
      throw new TypeError("No user id provided");
    }
    return await this.userRepository.getUserById(userId);
  };

  /**
   * Retrive the user avatar if one is registered in the database
   * @param userId
   */
  getPersonalAvatarByUserId = async (userId: number): Promise<Buffer | string | null> => {
    if (userId === undefined || userId === null) {
      throw new TypeError("No user id provided");
    }

    const selectedAvatarId = await this.userRepository.getUserAvatarChoice(userId);
    // the user has no avatar selected
    if (selectedAvatarId === null) {
      return null;
    }

    const userAvatar: Buffer | string = await this.userRepository.getUserSelectedAvatarInfo(selectedAvatarId);

    if (userAvatar === null) {
      throw new Error("No avatar found for this user");
    }

    return userAvatar;
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
    // get the file buffer (binary data)
    const fileData = fs.readFileSync(file.path);

    const update = await this.isUserAvatarNeedUpdate(userId, fileData, avatarReference);
    if (update) return update;

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

    await this.userRepository.setUserAvatarChoice(userId, registeredAvatar.avatarId);

    return registeredAvatar;
  };

  /**
   * Determine if the user avatar picture needs to be updated or not.
   * If not, return the avatar infos from the database. And updated the avatar choice on the user table.
   * @param userId
   * @param fileData
   * @param avatarReference
   * @returns
   */
  isUserAvatarNeedUpdate = async (
    userId: number,
    fileData: any,
    avatarReference: string
  ): Promise<AvatarDto | void> => {
    // check if avatar is in the database (by userId and avatarReference)
    const isAvatarInDataBase: AvatarDto | null = await this.userRepository.isAvatarInDataBase(userId, avatarReference);

    if (isAvatarInDataBase !== null && isAvatarInDataBase.avatarReference === avatarReference) {
      // if the blob is the same, then set the avatar choice to the user
      if (isAvatarInDataBase.avatarBlob.toString("base64") === fileData.toString("base64")) {
        await this.userRepository.setUserAvatarChoice(userId, isAvatarInDataBase.avatarId);
        return isAvatarInDataBase;
      }
      // else update the avatar blob as the user has send a different one
      const updatedAvatarRow = await this.userRepository.updateAvatarBlob(fileData, userId, avatarReference);
      await this.userRepository.setUserAvatarChoice(userId, updatedAvatarRow.avatarId);
      return updatedAvatarRow;
    }
  };

  /**
   * Set the default avatar choice for a user.
   * Either update the existing row in the database or create a new one.
   * @param userId
   * @param avatarReference
   * @returns avatar reference of the default avatar choice
   */
  setDefaultAvatarChoice = async (userId: number, avatarReference: string): Promise<string> => {
    const avatarIdRowToUpdate = await this.userRepository.isDefaultAvatarRowExist(userId);

    // if a row already exist for the default avatar choice, update it
    if (avatarIdRowToUpdate) {
      const updatedAvatarInfo = await this.userRepository.updatedDefaultAvatarRow(
        avatarIdRowToUpdate.avatarId,
        avatarReference
      );
      await this.userRepository.setUserAvatarChoice(userId, updatedAvatarInfo.avatarId);
      return updatedAvatarInfo.avatarReference;
    } else {
      const registeredDefaultAvatar = await this.userRepository.registerDefaultAvatar(userId, avatarReference);
      await this.userRepository.setUserAvatarChoice(userId, registeredDefaultAvatar.avatarId);
      return registeredDefaultAvatar.avatarReference;
    }
  };
}
