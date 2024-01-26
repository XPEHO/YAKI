import {TeamService} from "./team.service";
import {TeamLogoDto} from "./teamLogo.dto";

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

  /**
   * Verify if the query param is either teamIds or userId.
   * If the query param is teamIds, it will call the getTeamsLogoByTeamsId function.
   * If the query param is userId, it will call the getTeamsLogoByUserId function.
   * If the query param is neither teamIds or userId, it will return a 400 error.
   * @param req
   * @param res
   */
  getTeamsLogo = async (req: any, res: any) => {
    const queryParams = Object.keys(req.query)[0];

    if (queryParams === "teamIds") {
      this.getTeamsLogoByTeamsId(req, res);
    } else if (queryParams === "userId") {
      this.getTeamsLogoByUserId(req, res);
    } else {
      res.status(400).json({message: "invalid query param"});
    }
  };

  /**
   * Retrive a list of team logo given a list of team id.
   * If a team id does not have a logo, it will not be returned.
   * User query param, ex : ?teamIds=1,2,3
   * The querys if verified to make sure we receive only numbers, otherwise it will return a 400 error
   * @param req
   * @param res
   */
  getTeamsLogoByTeamsId = async (req: any, res: any) => {
    const teamIds = req.query.teamIds;
    const idsArray = this.teamsIdsValidation(teamIds);

    try {
      const teamsLogo = await this.teamService.getTeamsLogoByTeamsId(idsArray);

      if (teamsLogo.length === 0) {
        console.log("404 no team logo was found");
        res.status(404).json({message: "No team logo was found"});
      } else {
        console.log(
          "200 team logo was found for the teams :",
          teamsLogo.map((team) => team.teamLogoTeamId)
        );
        res.status(200).json(teamsLogo);
      }
    } catch (error: any) {
      // catch server errors
      res.status(500).json({message: error.message});
    }
  };

  /**
   * Verify if the teamIds query param (originaly a string) is valid by setting it to an array of numbers.
   * Allowing to check if any query param is not a number.
   * If the array is empty, it means that no ids were provided.
   * @param teamIds
   * @returns An array of valid team IDs.
   * @throws {Error} If the provided list contains invalid IDs or if no IDs are provided.
   */
  teamsIdsValidation = (teamIds: string) => {
    const idsArray = teamIds.split(",").map((id: string) => Number(id));

    if (idsArray.some(isNaN)) {
      throw new Error("invalid ids list provided");
    }
    if (idsArray.length === 0) {
      throw new Error("no ids provided");
    }

    return idsArray;
  };

  /**
   * Retrive a list of team logo given a user id, meaning its all teams the user is into.
   * If a team id does not have a logo, it will not be returned.
   * User query param, ex : ?userId=1
   * @param req
   * @param res
   */
  getTeamsLogoByUserId = async (req: any, res: any) => {
    const userId = Number(req.query.userId);

    if (isNaN(userId)) {
      throw new Error("invalid user id provided");
    }

    try {
      const teamsLogo = await this.teamService.getTeamsLogoByUserId(userId);

      if (teamsLogo.length === 0) {
        console.log("404 no team logo was found");
        res.status(404).json({message: "No team logo was found"});
      } else {
        console.log(
          "200 team logo was found for the teams :",
          teamsLogo.map((team: TeamLogoDto) => team.teamLogoTeamId)
        );
        res.status(200).json(teamsLogo);
      }
    } catch (error: any) {
      // catch server errors
      res.status(500).json({message: error.message});
    }
  };
}
