import type { AuthenticateType } from "@/models/authenticate.type";
import { environmentVar } from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

export class LoginService {
  /* `login` is a method of the `LoginService` class that takes in a `login`
    and a password in the header and returns a `JSON web token` and the id of the user. */
  login = async (login: string, password: string): Promise<AuthenticateType> => {
    try {
      const res = await fetch(`${URL}/login/authenticate`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          login: login,
          password: password,
        }),
      });

      if (!res.ok) {
        throw new Error(`Something went wrong during logging process`);
      }

      return await res.json();
    } catch (error: any) {
      console.error("error:", error.message);
      throw error;
    }
  };
}

export const loginService = Object.freeze(new LoginService());
