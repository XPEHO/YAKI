import fs from "fs";
import {AvatarDto} from "../user_avatar/avatar.dto";
import {AvatarRepository} from "./avatar.repository";
import {AvatarEnum} from "./avatar.enum";

export class AvatarService {
  avatarRepository: AvatarRepository;

  defaultAvatarsList: string[] = Object.values(AvatarEnum).filter((value) => value !== AvatarEnum.USERPICTURE);

  constructor(repository: AvatarRepository) {
    this.avatarRepository = repository;
  }

  /**
   * Get the avatar of a user.
   * @param userId
   * @returns return a Buffer Or a string (avatarReference for default app avatars) if the user has once selected. null if not
   */
  getAvatarByUserId = async (userId: number): Promise<Buffer | string | null> => {
    try {
      if (!userId) {
        throw new Error("No user id provided");
      }
      const userAvatar: Buffer | string | null = await this.avatarRepository.getUserAvartarChoiceByUserID(userId);
      return userAvatar;
    } catch (error: any) {
      console.error("Error get avatar : ", error.message);
      throw error;
    }
  };

  /**
   * Retrive the avatar choices of the users by their IDs if it exist
   * @param usersId List of users id to get the avatar choice from
   * @returns list of AvatarDto containing the avatar infos related to the users choice
   */
  getAvatarsByUsersId = async (usersId: number[]): Promise<AvatarDto[] | null> => {
    if (!usersId) {
      throw new Error("No user id provided");
    }
    try {
      const avatarList: AvatarDto[] | null = await this.avatarRepository.getUsersAvartarChoiceByUsersID(usersId);
      return avatarList;
    } catch (error: any) {
      console.error("Error get users avatar choice : ", error.message);
      throw error;
    }
  };

  /**
   * Register a new avatar for a user.
   * It reads the avatar file buffer which is a binary data, it's used to save the image in the database as bytea.
   *
   * Checks if the avatar already exists in the database, if it does, it updates the avatar.
   * Otherwise, it inserts a new avatar.
   * @param userId The ID of the user for whom the avatar is being registered.
   * @param avatarReference The reference to the avatar. This must be a value from the `AvatarEnum`.
   * @param file (Express.Multer.File): The avatar file that has been uploaded. This object includes various properties about the file, including its path on the server.
   * @param isSettingDefaultAvatar A boolean indicating whether a default avatar is being set.
   * @returns AvatarDto
   */
  setAvatarByUserId = async (
    userId: number,
    avatarReference: string,
    file: Express.Multer.File | null,
    isSettingDefaultAvatar: boolean
  ): Promise<AvatarDto> => {
    try {
      const referencesList = isSettingDefaultAvatar ? this.defaultAvatarsList : [AvatarEnum.USERPICTURE];
      const isAvatarExists: AvatarDto | null = await this.avatarRepository.getAvatarIfExistsByUserIdAndReference(
        userId,
        referencesList
      );
      // with default avatar the file param is null
      const fileData = file ? await fs.promises.readFile(file.path) : file;

      let avatarInfo: AvatarDto | null;
      if (isAvatarExists) {
        avatarInfo = await this.avatarRepository.updateAvatarWithBlobOrReference(
          isAvatarExists.avatarId,
          avatarReference,
          fileData
        );
      } else {
        avatarInfo = await this.avatarRepository.insertUserAvatar(userId, avatarReference, fileData, true);
      }
      await this.avatarRepository.updateUserAvatarChoice(userId, avatarInfo.avatarId);
      return avatarInfo;
    } catch (error: any) {
      console.error(`Error set ${isSettingDefaultAvatar ? "default" : "custom"} avatar: ${error.message}`);
      throw error;
    }
  };
}
