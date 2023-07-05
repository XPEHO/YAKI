import {environmentVar} from "@/envPlaceholder";
import {CaptainType} from "@/models/captain.type";
import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";


const URL: string = environmentVar.baseURL;

export class CaptainService {
    getAllCaptainByUserId = async (userId: number): Promise<CaptainType[]> => {
      const requestOptions = {
        method: 'GET',
        headers: authHeader(`${URL}/captains/user?=${userId}`),
        
      }
    const response = await fetch(`${URL}/captains/user?=${userId}`,requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };
}

export const captainService = Object.freeze(new CaptainService());