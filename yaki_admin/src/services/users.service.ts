import {environmentVar} from "@/envPlaceholder";
import {UserWithIdType} from "@/models/userWithId.type";
import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";

const URL: string = environmentVar.baseURL;

export class UserService {
  fetchUserInRange = async (idStart: number, idEnd: number): Promise<UserWithIdType[]> => {
    const response = await fetch(`${URL}/users/inRange?idStart=${idStart}&idEnd=${idEnd}`)
      .then((res) => res.json())
      .catch((err) => console.warn(err));

    return response;
  };
  getUserById = async (id: number): Promise<UserWithIdType>=> {
    const requestOptions = {
      method: 'POST',
      headers: authHeader(`${URL}/users/${id}`),
      
    }
    const response = await fetch(`${URL}/users/${id}`,requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));
    return response;
  };
}

export const usersService = Object.freeze(new UserService());
