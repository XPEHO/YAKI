import {TeamDtoIn} from "./team.dtoIn";
import {TeamRepository} from "./team.repository";

export class TeamService {
  teamRepository: TeamRepository;

  constructor(teamRepository: TeamRepository) {
    this.teamRepository = teamRepository;
  }

  getTeamByCaptainId = async (captain_id: number): Promise<TeamDtoIn> => {
    const team = await this.teamRepository.getTeamByCaptainId(captain_id);
    const teamDto: TeamDtoIn = new TeamDtoIn(team.team_id, team.team_captain_id, team.team_name);

    if (teamDto !== undefined) {
      return teamDto;
    } else {
      throw new TypeError("No team with this captain exists");
    }
  };

  /**
   * This function returns the list of teams that a team mate is in
   * and returns an error if the team mate is not in any teams
   * @param teamMateId the id of the team mate
   * @returns a list of teams that the team mate is in
   */
  getTeamByTeamMateId = async (teamMateId: number) => {
    const team = await this.teamRepository.getTeamByTeamMateId(teamMateId);
    if (team !== undefined) {
      return team;
    } else {
      throw new TypeError("No team with this team id exists");
    }
  };
}
