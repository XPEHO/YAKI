import type { TeamType } from "./team.type"

// Setting the base URL for the teams API endpoint
const url = "http://localhost:8080/teams/captain"

export class TeamService {
    /* `getAllTeamsWithinCaptain` is a method of the `TeamService` class that takes in a `number`
    parameter `id` and returns a `Promise` that resolves to an array of `TeamType` objects. */
    getAllTeamsWithinCaptain = async (id: number): Promise<TeamType[]> => {
        const res = await fetch(`${url}/${id}`)
        return await res.json()
    }
}

export const teamService = Object.freeze(new TeamService())