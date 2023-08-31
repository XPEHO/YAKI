import type {TeammateTypeOut, TeammateTypeIn} from "@/models/teammate.type";
import {environmentVar} from "@/envPlaceholder";
import {authHeader} from "@/utils/authUtils";
import {handleResponse} from "@/utils/responseUtils";
import {UserWithIdType} from "@/models/userWithId.type";

const URL: string = environmentVar.baseURL;

// Defining a TeamMateService class to handle HTTP requests to the API
export class TeammateService {
  // Defining a method to retrieve all team mates within a given team
  getAllWithinTeam = async (id: number): Promise<UserWithIdType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/teammates/team/${id}`),
    };
    // Sending a GET request to the API endpoint with the given team ID
    const res = await fetch(`${URL}/teammates/team/${id}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));
    return res;
    // Parsing the response body as JSON and returning it as an array of TeammateType objects
  };

  // assign a user to a team by "creating a teammate" : userID +
  createTeammate = async (data: TeammateTypeOut): Promise<TeammateTypeIn> => {
    const requestOptions = {
      method: "POST",
      body: JSON.stringify(data),
      headers: authHeader(`${URL}/teammates`),
      //"Access-Control-Allow-Origin": "*", needed ?
    };
    const response = await fetch(`${URL}/teammates`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  deleteTeammate = async (id: number): Promise<TeammateTypeIn> => {
    const requestOptions = {
      method: "PUT",
      headers: authHeader(`${URL}/teammates/disabled/${id}`),
    };
    return await fetch(`${URL}/teammates/disabled/${id}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));
  };
}

// Creating an instance of the TeamMateService class and freezing it to prevent modification
export const teammateService = Object.freeze(new TeammateService());
