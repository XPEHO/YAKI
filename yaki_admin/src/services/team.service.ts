import type { TeamType, TeamTypeOut } from "../models/team.type";
import { environmentVar } from "@/envPlaceholder";
import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";

const URL: string = environmentVar.baseURL;

export class TeamService {
  /* `getAllTeamsWithinCaptain` is a method of the `TeamService` class that takes in a `number`
    parameter `id` and returns a `Promise` that resolves to an array of `TeamType` objects. */
  getAllTeamsWithinCaptain = async (id: number): Promise<TeamType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/teams/captain/${id}`),
    };
    const response = await fetch(`${URL}/teams/captain/${id}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  /* getAllTeamsByCustomerId is a method of the TeamService class that takes in a number *
  parameter id and returns a Promise that resolves to an array of TeamType objects.*/
  getAllTeamsByCustomerId = async (id: number): Promise<TeamType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/teams/customer/${id}`),
    };
    const response = await fetch(`${URL}/teams/customer/${id}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  createTeam = async (
    cptId: number | null,
    teamName: string,
    customerId: number,
    teamDescription: string
  ): Promise<TeamType> => {
    const newTeam: TeamTypeOut = {
      captainsId: [cptId],
      teamName: teamName,
      customerId: customerId,
      teamDescription: teamDescription,
    };
    const requestOptions = {
      method: "POST",
      body: JSON.stringify(newTeam),
      headers: authHeader(`${URL}/teams`),
    };
    const res = await fetch(`${URL}/teams`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return res;
  };

  // might could use , customerId: number as parameter
  updateTeam = async (
    teamId: number,
    cptId: number | null,
    teamName: string | null,
    customerId: number | null,
    teamDescription: string | null
  ): Promise<TeamType> => {
    const updatedTeam: TeamTypeOut = {
      captainsId: [cptId],
      teamName: teamName,
      customerId: customerId,
      teamDescription: teamDescription,
    };
    const requestOptions = {
      method: "PUT",
      body: JSON.stringify(updatedTeam),
      headers: authHeader(`${URL}/teams/${teamId}`),
    };

    const res = await fetch(`${URL}/teams/${teamId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return res;
  };

  deleteTeam = async (teamId: number): Promise<TeamType> => {
    const requestOptions = {
      method: "PUT",
      headers: authHeader(`${URL}/teams/disabled/${teamId}`),
    };
    const res = await fetch(`${URL}/teams/disabled/${teamId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return res;
  };
}

export const teamService = Object.freeze(new TeamService());
