import { environmentVar } from "@/envPlaceholder";
import { TeamLogoType } from "@/models/TeamLogo.type";
import { useAuthStore } from "@/stores/authStore";
import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";

const URL: string = environmentVar.baseURL;

class TeamLogoService {
  getTeamLogo = async (teamId: number): Promise<TeamLogoType> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/teams/${teamId}/logo`),
    };

    const response = await fetch(`${URL}/teams/${teamId}/logo`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  createOrUpdateTeamLogo = async (teamId: number, logo: File): Promise<TeamLogoType> => {
    const formData = new FormData();
    formData.append("file", logo);

    const { user } = useAuthStore();

    const requestOptions = {
      method: "PUT",
      body: formData,
      headers: {
        Authorization: `Bearer ${user.token}`,
      },
    };

    const response = await fetch(`${URL}/teams/${teamId}/logo`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };
}

export const teamLogoService = Object.freeze(new TeamLogoService());
