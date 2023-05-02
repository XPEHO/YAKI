import type { TeamType } from "./team.type"

const url = "http://localhost:8080/teams/captain"

export class TeamService {
    getAllTeamsWithinCaptain = async (id: number): Promise<TeamType[]> => {
        const res = await fetch(`${url}/${id}`)
        return await res.json()
    }
}

export const teamService = Object.freeze(new TeamService())