import { environmentVar } from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

export class RegisterService {
  registerConfirm = async (token: string): Promise<string> => {
    const res = await fetch(`${URL}/login/registerConfirm?token=${token}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    });
    return await res.text();
  };
}

export const registerService = Object.freeze(new RegisterService());
