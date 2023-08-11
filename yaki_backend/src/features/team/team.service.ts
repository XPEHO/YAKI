import {TeamDtoIn} from "./team.dtoIn";
import {TeamRepository} from "./team.repository";

export class TeamService {
  teamRepository: TeamRepository;

  constructor(teamRepository: TeamRepository) {
    this.teamRepository = teamRepository;
  }

  // return a team list managed by a selected captain id
  getTeamsByCaptainId = async (captain_id: number): Promise<TeamDtoIn[]> => {
    const teams: TeamDtoIn[] = await this.teamRepository.getTeamByCaptainId(captain_id);
    if (teams !== undefined) {
      return teams;
    } else {
      throw new TypeError("No team with this captain exists");
    }
  };

  /**
   * This function returns the list of teams that a team mate is in
   * and returns an error if the team mate is not in any teams
   * @param teammateId the id of the team mate
   * @returns a list of teams that the team mate is in
   */
  getTeamByTeammateId = async (teammateId: number) => {
    const team = await this.teamRepository.getTeamByTeammateId(teammateId);
    if (team !== undefined) {
      return team;
    } else {
      throw new TypeError("No team with this team id exists");
    }
  };
}
