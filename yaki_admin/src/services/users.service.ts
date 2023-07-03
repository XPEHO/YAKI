import {environmentVar} from "@/envPlaceholder";
import {UserWithIdType} from "@/models/userWithId.type";

const URL: string = environmentVar.baseURL;

export class UserService {
  fetchUserInRange = async (idStart: number, idEnd: number): Promise<UserWithIdType[]> => {
    const response = await fetch(`${URL}/users/inRange?idStart=${idStart}&idEnd=${idEnd}`)
      .then((res) => res.json())
      .catch((err) => console.warn(err));

    return response;
  };
}

export const usersService = Object.freeze(new UserService());
