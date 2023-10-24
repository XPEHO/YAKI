import {TeamRepository} from "./team.repository";

export class TeamService {
  teamRepository: TeamRepository;

  constructor(teamRepository: TeamRepository) {
    this.teamRepository = teamRepository;
  }

  /**
   * retrive the list of teams a user is part of
   * @param userId the id of the team mate
   * @returns a list of teams that a user is part of
   */
  getTeamByTeammateId = async (userId: number) => {
    const team = await this.teamRepository.getTeamByTeammateId(userId);
    if (team !== undefined) {
      return team;
    } else {
      throw new TypeError("No team with this team id exists");
    }
  };

  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //========================================================
  /**
   * This function returns the list of teams that a team mate is in
   * and returns an error if the team mate is not in any teams
   * @param userId the id of the team mate
   * @returns a list of teams that the team mate is in
   */
  getTeamByUserId = async (userId: number) => {
    const teams = await this.teamRepository.getTeamByTeammateId(userId);
    if (teams !== undefined) {
      return teams;
    } else {
      throw new TypeError("No team with this user id exists");
    }
  };
}
