import {Client, QueryResult} from "pg";
import "dotenv/config";
import {UserToRegisterOut} from "./toRegister.dtoOut";
import ToRegisterRes from "./toRegisterRes.dto";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";
import {AvatarDto} from "./avatar.dto";
import {UserInformationDto} from "./userInformations.dto";

export class UserRepository {
  /**
   * Seek a user in the database by its login value
   * @param username
   * @param password
   * @returns
   */
  getByLogin = async (username: string) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    // selected attribut do not work ?
    // user_id, user_last_name, user_first_name, user_email, teammate_id, captain_id, user_enabled

    const query = `
        SELECT *
        FROM public.user u
        LEFT JOIN public.teammate tm
        ON u.user_id = tm.teammate_user_id
        LEFT JOIN public.captain c
        ON u.user_id = c.captain_user_id
        WHERE user_login = $1
      `;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [username]);
    await client.end();
    // If the user wasn't found in the DB
    if (poolResult.rowCount === 0) {
      throw new Error("Bad authentification details");
    }
    // If the user still hasn't confirmed his account
    if (poolResult.rows[0].user_enabled === false) {
      throw new Error("This account isn't activated");
    }
    // "else" return the user
    return poolResult.rows[0];
  };

  /**
   * register a user that signed in with the mobile application
   * @param user user data coming from registration process
   * @returns response from admin api after email confirmation & successfull registration
   */
  registerUser = async (user: UserToRegisterOut): Promise<ToRegisterRes> => {
    try {
      const registerResponse = await fetch(`${process.env.ADMIN_API}/login/register`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(user),
      });
      if (!registerResponse.ok) {
        if (registerResponse.status === 417)
          //handle the email already used error
          throw new EmailAlreadyExistsError("email already used");
      }
      let jsonResponse = await registerResponse.json();
      return jsonResponse;
    } catch (err) {
      console.warn(err);
      throw err;
    }
  };

  getUserById = async (userId: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
      SELECT 
      user_last_name, 
      user_first_name, 
      user_email, 
      a.avatar_reference
      FROM public.user u
      LEFT JOIN public.avatar a ON u.user_id = a.avatar_user_id
      WHERE user_id = $1
      `;
    client.connect();
    try {
      const poolResult: QueryResult = await client.query(query, [userId]);
      if (poolResult.rowCount === 0) {
        throw new TypeError("Error during user informations fetching");
      }
      const result = poolResult.rows[0];

      const userInformations = new UserInformationDto(
        result.user_last_name,
        result.user_first_name,
        result.user_email,
        result.avatar_reference
      );

      return userInformations;
    } finally {
      await client.end();
    }
  };

  /**
   *  retrieve the avatar id selected by the user
   * @param userId
   * @returns avatar id selected by the user or null if no avatar is selected
   */
  getUserAvatarChoice = async (userId: number): Promise<number | null> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
    });
    const query = `
      SELECT u.user_avatar_choice 
      FROM public.user u
      WHERE u.user_id = $1
    `;
    client.connect();
    try {
      const result = await client.query(query, [userId]);

      if (result.rowCount === 0) {
        throw new TypeError("Error during user avatar choice fetching");
      }

      return result.rows[0].user_avatar_choice;
    } finally {
      await client.end();
    }
  };

  /**
   * Retrive the personal user avatar if one is registered in the database
   * @param userId
   * @returns buffer of the avatar blob, value can be null if no avatar is registered
   */
  getUserSelectedAvatarInfo = async (avatarId: number): Promise<Buffer | string> => {
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
        WHERE a.avatar_id = $1
      `;

    client.connect();
    try {
      const result = await client.query(query, [avatarId]);

      if (result.rowCount === 0) {
        throw new TypeError("Error during user avatar fetching");
      }
      return result.rows[0].avatar_blob ?? result.rows[0].avatar_reference;
    } finally {
      await client.end();
    }
  };

  /**
   * Check if the user already has an avatar in the database saved under the selected reference
   * @param userId
   * @param avatarReference
   * @returns null if the user doesn't have avatar, or the avatar blob if exists
   */
  isAvatarInDataBase = async (userId: number, avatarReference: string): Promise<AvatarDto | null> => {
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
          WHERE a.avatar_user_id = $1 
          AND a.avatar_reference = $2
          `;
    client.connect();
    try {
      const poolResult = await client.query(query, [userId, avatarReference]);

      if (poolResult.rowCount === 0) {
        return null;
      }
      const result = poolResult.rows[0];

      const registeredAvatar = new AvatarDto(
        result.avatar_id ?? 0,
        result.avatar_user_id,
        result.avatar_reference,
        result.avatar_blob,
        result.avatar_is_validated
      );
      return registeredAvatar;
    } finally {
      await client.end();
    }
  };

  /**
   * Update an avatar row in the database if one already exist with a given avatarReference, but the image comparison failed.
   * Meaning the user has send a new image to replace the old one.
   * @param userId
   * @param blob
   * @returns
   */
  updateAvatarBlob = async (blob: Buffer, userId: number, avatarReference: string): Promise<AvatarDto> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    // TODO : WILL NEED TO CHANGE THE AVATAR IS VALIDATED TO FALSE WHEN ADMIN VALIDATION WILL BE IMPLEMENTED
    const query = `
        UPDATE avatar
        SET avatar_blob = $1, avatar_is_validated = true
        WHERE avatar_user_id = $2 AND avatar_reference = $3
        RETURNING *
      `;
    client.connect();
    try {
      const poolResult = await client.query(query, [blob, userId, avatarReference]);

      if (poolResult.rowCount === 0) {
        throw new Error("Error while updating the avatar");
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
    } finally {
      await client.end();
    }
  };

  /**
   *  Register a new avatar for a user
   * @param userId
   * @param avatarReference avatar enum
   * @param blob avatar blob bytea
   * @param isValidated (will be set to true for applications avatar)
   */
  registerNewAvatar = async (
    userId: number,
    avatarReference: string,
    blob: Buffer,
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
      const poolResult = await client.query(query, [userId, avatarReference, blob, isValidated]);
      if (poolResult.rowCount === 0) {
        throw new Error("Error while registering a new avatar");
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
    } finally {
      await client.end();
    }
  };

  /**
   * check if a row exist in the avatar table for a given user id with default avatar reference
   * @param userId
   * @returns avatar id if exist, null if not
   */
  isDefaultAvatarRowExist = async (userId: number): Promise<AvatarDto | null> => {
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
      WHERE a.avatar_user_id = $1 
      AND a.avatar_reference IN ('avatarH', 'avatarF', 'avatarM', 'avatarN', 'avatarNone') 
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
    } finally {
      await client.end();
    }
  };

  /**
   * Update the row with the default avatar choice for a user, with the new avatar reference
   * @param avatarId
   * @param avatarReference
   * @returns AvatarDto with information of the default avatar row updated
   */
  updatedDefaultAvatarRow = async (avatarId: number, avatarReference: string): Promise<AvatarDto> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
      UPDATE avatar
      SET avatar_reference = $1
      WHERE avatar_id = $2
      RETURNING *
    `;
    client.connect();
    try {
      const result = await client.query(query, [avatarReference, avatarId]);

      if (result.rowCount === 0) {
        throw new Error("Error while updating default avatar row");
      }

      const updatedRow = new AvatarDto(
        result.rows[0].avatar_id,
        result.rows[0].avatar_user_id,
        result.rows[0].avatar_reference,
        result.rows[0].avatar_blob,
        result.rows[0].avatar_is_validated
      );
      return updatedRow;
    } finally {
      await client.end();
    }
  };

  /**
   * Create a new row in the avatar table for the default avatar choice
   * @param userId
   * @param avatarReference
   * @returns AvatarDto with information about the default avatar row created
   */
  registerDefaultAvatar = async (userId: number, avatarReference: string): Promise<AvatarDto> => {
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
      const result = await client.query(query, [userId, avatarReference, null, true]);
      if (result.rowCount === 0) {
        throw new Error("Error while registering defaut avatar");
      }

      const registeredDefaultAvatarRow = new AvatarDto(
        result.rows[0].avatar_id,
        result.rows[0].avatar_user_id,
        result.rows[0].avatar_reference,
        result.rows[0].avatar_blob,
        result.rows[0].avatar_is_validated
      );

      return registeredDefaultAvatarRow;
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
  setUserAvatarChoice = async (userId: number, avatarId: number): Promise<number> => {
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
      if (result.rowCount === 0 && result.rows[0].user_avatar_choice !== avatarId) {
        throw new Error("Error while setting the avatar choice");
      }
      return result.rows[0].user_avatar_choice;
    } finally {
      await client.end();
    }
  };
}
