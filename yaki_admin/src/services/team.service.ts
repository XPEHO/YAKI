import type {TeamType} from "../models/team.type";
import {environmentVar} from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

export class TeamService {
  /* `getAllTeamsWithinCaptain` is a method of the `TeamService` class that takes in a `number`
    parameter `id` and returns a `Promise` that resolves to an array of `TeamType` objects. */
  getAllTeamsWithinCaptain = async (id: number): Promise<TeamType[]> => {
    const res = await fetch(`${URL}/teams/captain/${id}`);
    return await res.json();
  };
}

export const teamService = Object.freeze(new TeamService());
