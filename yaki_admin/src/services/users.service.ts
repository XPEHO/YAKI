import { environmentVar } from "@/envPlaceholder";
import { UserPagesResponseType } from "@/models/userPages.type";
import { UserWithIdType } from "@/models/userWithId.type";
import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";

const URL: string = environmentVar.baseURL;

export class UserService {
  fetchUserInRange = async (idStart: number, idEnd: number): Promise<UserWithIdType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/users/inRange?idStart=${idStart}&idEnd=${idEnd}`),
    };
    const response = await fetch(
      `${URL}/users/inRange?idStart=${idStart}&idEnd=${idEnd}`,
      requestOptions,
    )
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };
  getUserById = async (id: number): Promise<UserWithIdType> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/users/${id}`),
    };
    const response = await fetch(`${URL}/users/${id}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));
    return response;
  };

  getUsersByPage = async (page: number, size: number): Promise<UserPagesResponseType> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/users?page=${page}&size=${size}`),
    };

    const response = await fetch(`${URL}/users?page=${page}&size=${size}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  getCurrentUser = async (): Promise<UserWithIdType> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/users/current-user`),
    };
    const response = await fetch(`${URL}/users/current-user`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };
}

export const usersService = Object.freeze(new UserService());
