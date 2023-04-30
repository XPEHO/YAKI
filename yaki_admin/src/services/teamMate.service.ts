import type { TeamMateType } from "./teamMate.type"

const url = "http://localhost:8080/teammates/team"

export class TeamMateService {
    getAllWithinTeam = async (id: number): Promise<TeamMateType[]> => {
        const res = await fetch(`${url}/${id}`)
        return await res.json()
    }
}

export const teamMateService = Object.freeze(new TeamMateService())