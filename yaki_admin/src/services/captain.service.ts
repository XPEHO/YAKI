import {environmentVar} from "@/envPlaceholder";
import {CaptainType} from "@/models/captain.type";

const URL: string = environmentVar.baseURL;

export class CaptainService {
    getAllCaptainByUserId = async (userId: number): Promise<CaptainType[]> => {
    const response = await fetch(`${URL}/captains/user?=${userId}`,{
        method: 'GET',
        headers:{
            'Content-Type': 'application/json',
            'Authorization' : 'value'
        },
    })
      .then((res) => res.json())
      .catch((err) => console.warn(err));

    return response;
  };
}

export const captainService = Object.freeze(new CaptainService());