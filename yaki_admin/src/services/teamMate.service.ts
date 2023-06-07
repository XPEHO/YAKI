import type {TeamMateType} from "./teamMate.type";

const URL: string | undefined = import.meta.env.VITE_API_URL;

// Defining a TeamMateService class to handle HTTP requests to the API
export class TeamMateService {
  // Defining a method to retrieve all team mates within a given team
  getAllWithinTeam = async (id: number): Promise<TeamMateType[]> => {
    // Sending a GET request to the API endpoint with the given team ID
    const res = await fetch(`${URL}/teammates/team/${id}`);
    // Parsing the response body as JSON and returning it as an array of TeamMateType objects
    return await res.json();
  };
}

// Creating an instance of the TeamMateService class and freezing it to prevent modification
export const teamMateService = Object.freeze(new TeamMateService());
