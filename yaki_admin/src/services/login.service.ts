import type { AuthenticateType } from "@/models/authenticate.type";
import { environmentVar } from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

export class LoginService {
  /* `login` is a method of the `LoginService` class that takes in a `login`
    and a password in the header and returns a `JSON web token` and the id of the user. */
  login = async (login: string, password: string): Promise<AuthenticateType> => {
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
    return await res.json();
  };
}

export const loginService = Object.freeze(new LoginService());
