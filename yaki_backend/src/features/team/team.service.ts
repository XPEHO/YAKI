import { TeamRepository } from "./team.repository";

export class TeamService {
    teamRepository: TeamRepository

    constructor(teamRepository: TeamRepository) {
        this.teamRepository = teamRepository
    }

    getByCaptainId = async (captain_id: number) => {
        const captain = await this.teamRepository.getByCaptainId(captain_id);
        if(captain !== undefined) {
            return captain;
        } else {
            throw new TypeError("No team with this captain exists")
        }
    }
}