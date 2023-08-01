import {Pool, QueryResult} from "pg";
import "dotenv/config";
import {UserToRegisterOut} from "./toRegister.dtoOut";
import ToRegisterRes from "./toRegisterRes.dto";

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
    const query = `SELECT * FROM public.user u
        LEFT JOIN public.team_mate tm
        ON u.user_id = tm.team_mate_user_id
        LEFT JOIN public.captain c
        ON u.user_id = c.captain_user_id
        WHERE user_login = $1;`;
    const poolResult: QueryResult = await pool.query(query, [username]);
    await pool.end();
    // If the user was found in the database
    if (poolResult.rowCount > 0) {
      return poolResult.rows[0];
    } else {
      throw new Error("Bad authentification details");
    }
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
          throw new TypeError("email already used")
      }
      let jsonResponse =  await registerResponse.json();
      console.log(registerResponse)
      return jsonResponse;
    }
    catch(err){
      console.warn(err)
      throw err;
    }
  };
}
