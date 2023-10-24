import {TeammateService as TeammateService} from "./teammate.service";
import {Response, Request} from "express";

export class TeammateController {
  service: TeammateService;

  constructor(service: TeammateService) {
    this.service = service;
  }

  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //========================================================
  getByTeamIdWithLastDeclaration = async (req: Request, res: Response) => {
    const userId = Number(req.query.userId);
    try {
      const teammates = await this.service.getByTeamIdWithLastDeclaration(userId);
      res.send(teammates);
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(404).json({message: error.message});
      } else {
        res.status(500).json({message: error.message});
      }
    }
  };

  getTeammatesDeclarationsFromUserTeams = async (req: Request, res: Response) => {
    const userId = Number(req.query.userId);
    try {
      const teammates = await this.service.getTeammatesDeclarationsFromUserTeams(userId);
      res.send(teammates);
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(404).json({message: error.message});
      } else {
        res.status(500).json({message: error.message});
      }
    }
  };
}
