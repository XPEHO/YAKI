import {Pool, QueryResult} from "pg";
import "dotenv/config";
import {UserToRegisterOut} from "./toRegister.dtoOut";
import ToRegisterRes from "./toRegisterRes.dto";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError"

export class UserRepository {
  /**
   * Seek a user in the database by its login value
   * @param username
   * @param password
   * @returns
   */
  getByLogin = async (username: string) => {
    const pool = new Pool({
      user: `${process.env.DB_ROLE}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_ROLE_PWD}`,
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
    const poolResult: QueryResult = await pool.query(query, [username]);
    await pool.end();

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
   * resgister a user that signed in with the mobile application
   * @param user user data coming from registration process
   * @returns response from admin api after email confirmation & successfull registration
   */
  registerUser = async (user: UserToRegisterOut): Promise<ToRegisterRes> => {
    try{
    const registerResponse = await fetch(`${process.env.ADMIN_API}/login/register`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(user),
    });
      if(!registerResponse.ok){
        if(registerResponse.status === 417)
        //handle the email already used error
          throw new EmailAlreadyExistsError("email already used")
      }
      let jsonResponse =  await registerResponse.json();
      return jsonResponse;
    }
    catch(err){
      console.warn(err)
      throw err;
    }
  };
}
