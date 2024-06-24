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

  getUsersByPage = async (
    page: number,
    size: number,
    customerId: number | null = null,
    excludeCaptains: boolean = false,
    excludeTeamId: number | null = null,
  ): Promise<UserPagesResponseType> => {
    let requestParams = `?page=${page}&size=${size}`;

    if (customerId != null) {
      requestParams += `&customerId=${customerId}`;
      if (excludeCaptains) {
        requestParams += `&excludeCaptains=${excludeCaptains}`;
      } else if (excludeTeamId != null) {
        requestParams += `&excludeTeamId=${excludeTeamId}`;
      }
    }

    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/users${requestParams}`),
    };

    const response = await fetch(`${URL}/users${requestParams}`, requestOptions)
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
