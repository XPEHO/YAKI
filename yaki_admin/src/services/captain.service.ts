import { environmentVar } from "@/envPlaceholder";
import { CaptainType } from "@/models/captain.type";
import { UserWithIdType } from "@/models/userWithId.type";
import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";

const URL: string = environmentVar.baseURL;

export class CaptainService {
  getAllCaptainByUserId = async (userId: number): Promise<CaptainType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/captains/user/${userId}`),
    };
    const response = await fetch(`${URL}/captains/user/${userId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  getAllCaptainsByCustomerId = async (customerId: number): Promise<UserWithIdType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/captains/customer/${customerId}`),
    };
    const response = await fetch(`${URL}/captains/customer/${customerId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  // create a captain
  createCaptain = async (data: CaptainType): Promise<CaptainType> => {
    const requestOptions = {
      method: "POST",
      body: JSON.stringify(data),
      headers: authHeader(`${URL}/captains`),
    };
    await fetch(`${URL}/captains`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return data;
  };

  //delete a captain
  deleteCaptain = async (captainId: number): Promise<void> => {
    const requestOptions = {
      method: "DELETE",
      headers: authHeader(`${URL}/captains/delete/${captainId}`),
    };
    await fetch(`${URL}/captains/delete/${captainId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));
  };
  getCaptain = async (captainId: number): Promise<CaptainType> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/captains/${captainId}`),
    };
    const response = await fetch(`${URL}/captains/${captainId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };
}

export const captainService = Object.freeze(new CaptainService());
