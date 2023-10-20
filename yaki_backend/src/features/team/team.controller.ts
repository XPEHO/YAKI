import {TeamService} from "./team.service";

export class TeamController {
  private teamService: TeamService;

  constructor(teamService: TeamService) {
    this.teamService = teamService;
  }

  /**
   * This function returns the list of teams that a user is in
   * and returns an error if the user is not in any teams
   * @param req the request object
   * @param res the response object
   * @returns a list of teams that the user is in
   */
  getTeamByTeammateId = async (req: any, res: any) => {
    const userId = Number(req.query.userId);
    try {
      const team = await this.teamService.getTeamByTeammateId(userId);
      res.status(200).json(team);
    } catch (error: any) {
      if (error instanceof TypeError) {
        // catch not found errors
        res.status(404).json({message: error.message});
      } else {
        // catch server errors
        res.status(500).json({message: error.message});
      }
    }
  };
}
