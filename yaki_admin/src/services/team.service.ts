import type {TeamType} from "./team.type";

//const URL: string | undefined = import.meta.env.VITE_API_URL;
//const URL: string | undefined = 'https://yaki.uat.xpeho.fr/admin-api';
export class TeamService {
  /* `getAllTeamsWithinCaptain` is a method of the `TeamService` class that takes in a `number`
    parameter `id` and returns a `Promise` that resolves to an array of `TeamType` objects. */
  getAllTeamsWithinCaptain = async (id: number): Promise<TeamType[]> => {
    const res = await fetch(`https://yaki.uat.xpeho.fr/admin-api/teams/captain/${id}`);
    return await res.json();
  };
}

export const teamService = Object.freeze(new TeamService());
