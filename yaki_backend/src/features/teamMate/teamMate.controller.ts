import {TeammateService as TeammateService} from "./teamate.service";
import {Response, Request} from "express";

export class TeammateController {
  service: TeammateService;

  constructor(service: TeammateService) {
    this.service = service;
  }

  getByTeamIdWithLastDeclaration = async (req: Request, res: Response) => {
    const captainId = Number(req.query.captainId);
    try {
      const teamMates = await this.service.getByTeamIdWithLastDeclaration(captainId);
      res.send(teamMates);
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(404).json({message: error.message});
      } else {
        res.status(500).json({message: error.message});
      }
    }
  };
}
