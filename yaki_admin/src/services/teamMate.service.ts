import type {TeamMateType, TeammateToCreateType, TeammateReturnType} from "@/models/teamMate.type";
import {environmentVar} from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

// Defining a TeamMateService class to handle HTTP requests to the API
export class TeamMateService {
  // Defining a method to retrieve all team mates within a given team
  getAllWithinTeam = async (id: number): Promise<TeamMateType[]> => {
    // Sending a GET request to the API endpoint with the given team ID
    const res = await fetch(`${URL}/teammates/team/${id}`);
    // Parsing the response body as JSON and returning it as an array of TeamMateType objects
    return await res.json();
  };

  // assign a user to a team by "creating a teammate" : userID +
  createTeammate = async (data: TeammateToCreateType): Promise<TeammateReturnType> => {
    const response = await fetch(`${URL}/teammates`, {
      method: "POST",
      body: JSON.stringify(data),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
      .then((res) => res.json())
      .catch((err) => console.warn(err));

    return response;
  };

  deleteTeammate = async (id: number): Promise<TeammateReturnType> => {
    return await fetch(`${URL}/teammates`, {
      method: "DELETE",
    }).then((res) => res.json());
  };
}

// Creating an instance of the TeamMateService class and freezing it to prevent modification
export const teamMateService = Object.freeze(new TeamMateService());
