import type {TeamType, TeamTypeOut} from "../models/team.type";
import {environmentVar} from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

export class TeamService {
  /* `getAllTeamsWithinCaptain` is a method of the `TeamService` class that takes in a `number`
    parameter `id` and returns a `Promise` that resolves to an array of `TeamType` objects. */
  getAllTeamsWithinCaptain = async (id: number): Promise<TeamType[]> => {
    const res = await fetch(`${URL}/teams/captain/${id}`);
    return await res.json();
  };

  createTeam = async (cptId: number, teamName: string): Promise<TeamType> => {
    const newTeam: TeamTypeOut = {captainId: cptId, teamName: teamName};

    const res = await fetch(`${URL}/teams`, {
      method: "POST",
      body: JSON.stringify(newTeam),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    }).then((res) => res.json());

    return res;
  };

  updateTeam = async (teamId: number, cptId: number, teamName: string): Promise<TeamType> => {
    const newTeam: TeamTypeOut = {captainId: cptId, teamName: teamName};

    const res = await fetch(`${URL}/teams/${teamId}`, {
      method: "PUT",
      body: JSON.stringify(newTeam),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    }).then((res) => res.json());

    return res;
  };

  deleteTeam = async (teamId: number): Promise<TeamType> => {
    const res = await fetch(`${URL}/teams/${teamId}`, {
      method: "DELETE",
    }).then((res) => res.json());

    return res;
  };
}

export const teamService = Object.freeze(new TeamService());
