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

    /**
     * This function returns the list of teams that a team mate is in
     * and returns an error if the team mate is not in any teams
     * @param team_mate_id the id of the team mate
     * @returns a list of teams that the team mate is in
     */
    getTeamByTeamMateId = async (team_mate_id: number) => {
        const team = await this.teamRepository.getTeamByTeamMateId(team_mate_id);
        if(team !== undefined) {
            return team;
        } else {
            throw new TypeError("No team with this team id exists")
        }
    }

}