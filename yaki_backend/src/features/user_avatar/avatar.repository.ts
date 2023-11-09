import {Client} from "pg";
import {AvatarDto} from "./avatar.dto";

export class AvatarRepository {
  /**
   * Retrive the avatar blob from the database or the avatarReference.
   * The userId will be used to first get the avatarId from the user table,
   * and then retrive the Avatar information from the avatar table give the corresponding avatarId.
   * @param avatarId
   * @returns buffer of the avatar blob, value can be null if no avatar is registered
   */
  // invoked in avatarService.getAvatarByUserId
  getUserAvartarChoiceByUserID = async (userId: number): Promise<Buffer | string | null> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
        SELECT *
        FROM public.avatar a
        WHERE a.avatar_id = (
          SELECT u.user_avatar_choice 
            FROM public.user u
            WHERE u.user_id = $1
       )
      `;
    client.connect();
    try {
      const result = await client.query(query, [userId]);

      if (result.rowCount === 0) {
        return null;
      }
      return result.rows[0].avatar_blob ?? result.rows[0].avatar_reference;
    } catch (error) {
      throw new Error("Error during avatar fetching: " + (error as Error).message);
    } finally {
      await client.end();
    }
  };

  /**
   * update the user table to set the avatar Id, representing the avatar selected by the user
   * @param userId
   * @param avatarId
   * @returns the avatar id selected by the user
   */
  updateUserAvatarChoice = async (userId: number, avatarId: number): Promise<number> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
        UPDATE public.user
        SET user_avatar_choice = $1
        WHERE user_id = $2
        RETURNING user_avatar_choice
      `;
    client.connect();
    try {
      const result = await client.query(query, [avatarId, userId]);
      if (result.rows[0].user_avatar_choice !== avatarId) {
        throw new Error("Error while setting the avatar choice");
      }
      return result.rows[0].user_avatar_choice;
    } catch (error) {
      throw new Error("Error during user avatar selection updated: " + (error as Error).message);
    } finally {
      await client.end();
    }
  };

  /**
   * Register a new avatar row for a user (default or cutom avatar)
   * @param userId
   * @param avatarReference reference of the inserted avatar
   * @param blob, can be null if the avatar is a default avatar
   * @param isValidated value is false for a custom avatar, and true for a default avatar
   * @returns AvatarDto with information of the avatar row inserted
   */
  insertUserAvatar = async (
    userId: number,
    avatarReference: string,
    blob: Buffer | null,
    isValidated: boolean
  ): Promise<AvatarDto> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
      INSERT INTO avatar 
      (
        avatar_user_id, 
        avatar_reference, 
        avatar_blob, 
        avatar_is_validated
      )
      VALUES ($1, $2, $3, $4)
      RETURNING *
    `;
    client.connect();
    try {
      // TODO : WILL NEED TO CHANGE THE AVATAR IS VALIDATED TO FALSE WHEN ADMIN VALIDATION WILL BE IMPLEMENTED
      const poolResult = await client.query(query, [userId, avatarReference, blob, isValidated]);
      const result = poolResult.rows[0];
      const registeredAvatar = new AvatarDto(
        result.avatar_id,
        result.avatar_user_id,
        result.avatar_reference,
        result.avatar_blob,
        result.avatar_is_validated
      );
      return registeredAvatar;
    } catch (error) {
      throw new Error("Error during avatar insertion: " + (error as Error).message);
    } finally {
      await client.end();
    }
  };

  /**
   * Retrieves an avatar from the database if one exists with a given userId and avatarsReference.
   * @param userId
   * @param avatarsReference An array of avatar references to search for.
   * @returns AvatarDto if an avatar is found, or null if no avatar is found.
   *
   * @throws Will throw an error if there is an issue retrieving the avatar information from the database.
   */
  getAvatarIfExistsByUserIdAndReference = async (
    userId: number,
    avatarsReference: string[]
  ): Promise<AvatarDto | null> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    // porperly format the array in a single string to be used in the query
    const avatarsReferenceString = avatarsReference.map((value) => `'${value}'`).join(", ");

    const query = `
      SELECT * 
      FROM public.avatar a
      WHERE a.avatar_user_id = $1 
      AND a.avatar_reference IN (${avatarsReferenceString}) 
    `;

    client.connect();
    try {
      const result = await client.query(query, [userId]);

      if (result.rowCount === 0) {
        return null;
      }
      const updatedRow = new AvatarDto(
        result.rows[0].avatar_id,
        result.rows[0].avatar_user_id,
        result.rows[0].avatar_reference,
        result.rows[0].avatar_blob,
        result.rows[0].avatar_is_validated
      );
      return updatedRow;
    } catch (error) {
      throw new Error("Get avatar info error : " + (error as Error).message);
    } finally {
      await client.end();
    }
  };

  /**
   * Updates an avatar in the database with either a blob or a reference.
   * @param avatarId
   * @param avatarReference Provide default avatar reference. This is used if blob is null.
   * @param blob The custom user avatar pictur. If this is provided,
   *
   * @returns AvatarDto
   *
   * @throws Will throw an error if no rows were updated or if there was an error during the update.
   */
  updateAvatarWithBlobOrReference = async (
    avatarId: number,
    avatarReference: string | null,
    blob: Buffer | null
  ): Promise<AvatarDto> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    let query: string;
    let params: (number | Buffer)[] | (string | number)[];
    if (blob) {
      // TODO : WILL NEED TO CHANGE THE AVATAR IS VALIDATED TO FALSE WHEN ADMIN VALIDATION WILL BE IMPLEMENTED
      query = `
        UPDATE avatar
        SET avatar_blob = $1, avatar_is_validated = true
        WHERE avatar_id = $2
        RETURNING *
      `;
      params = [blob, avatarId];
    } else {
      query = `
        UPDATE avatar
        SET avatar_reference = $1
        WHERE avatar_id = $2
        RETURNING *
      `;
      params = [avatarReference!, avatarId];
    }

    client.connect();
    try {
      const poolResult = await client.query(query, params);
      if (poolResult.rowCount === 0) {
        throw new Error("No rows updated during avatar update");
      }
      const result = poolResult.rows[0];
      const registeredAvatar = new AvatarDto(
        result.avatar_id,
        result.avatar_user_id,
        result.avatar_reference,
        result.avatar_blob,
        result.avatar_is_validated
      );
      return registeredAvatar;
    } catch (error) {
      throw new Error("Error at avatar update : " + (error as Error).message);
    } finally {
      await client.end();
    }
  };
}
