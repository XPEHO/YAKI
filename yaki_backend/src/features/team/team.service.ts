import { TeamRepository } from "./team.repository";

export class TeamService {
    teamRepository: TeamRepository

    constructor(teamRepository: TeamRepository) {
        this.teamRepository = teamRepository
    }

    getByCaptainId = async (captain_id: number) => {
        return this.teamRepository.getByCaptainId(captain_id)
    }
}