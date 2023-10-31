import {Client, QueryResult} from "pg";
import "dotenv/config";
import {UserToRegisterOut} from "./toRegister.dtoOut";
import ToRegisterRes from "./toRegisterRes.dto";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";
import {AvatarDto} from "./avatar.dto";

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
      console.log("this user isn't activated");
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
        SELECT user_last_name, user_first_name, user_email
        FROM public.user u
        WHERE user_id = $1
      `;

    try {
      await client.connect();
      const poolResult: QueryResult = await client.query(query, [userId]);
      await client.end();

      return poolResult.rows;
    } catch (error: any) {
      console.error(error);
      throw error;
    }
  };

  /**
   *  Register a new avatar for a user
   * @param userId
   * @param avatarReference avatar enum
   * @param blob avatar blob bytea
   * @param isValidated (will be set to true for applications avatar)
   */
  registerNewAvatar = async (userId: number, avatarReference: string, blob: Buffer, isValidated: boolean) => {
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
        throw new Error("Error while registering the avatar");
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
   * Update an avatar row in the database if one already exist with a given avatarReference, but the image comparison failed.
   * Meaning the user has send a new image to replace the old one.
   * @param userId
   * @param blob
   * @returns
   */
  updateAvatarBlob = async (blob: Buffer, userId: number, avatarReference: string) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
      UPDATE avatar
      SET avatar_blob = $1
      WHERE avatar_user_id = $2 AND avatar_reference = $3::avatar_enum
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
        AND a.avatar_reference = $2::avatar_enum
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
   * update the user table to set the avatar Id, representing the avatar selected by the user
   * @param userId
   * @param avatarId
   * @returns
   */
  setAvatarChoiceInUser = async (userId: number, avatarId: number) => {
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
