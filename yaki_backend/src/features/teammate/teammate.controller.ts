import {DatabaseError} from "../../errors/dataOrDataBaseError";
import {STATUS_CODES} from "../../utils/statusCode.enum";
import {TeammateService as TeammateService} from "./teammate.service";
import {Response, Request} from "express";

export class TeammateController {
  service: TeammateService;

  constructor(service: TeammateService) {
    this.service = service;
  }

  getTeammatesDeclarationsAndAvatarFromUserTeams = async (req: Request, res: Response) => {
    const userId = Number(req.query.userId);
    try {
      const teammates = await this.service.getTeammatesDeclarationsWithAvatarFromUserTeams(userId);
      res.status(STATUS_CODES.OK).send(teammates);
    } catch (error: any) {
      if (error instanceof DatabaseError) {
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({message: error.message});
      } else {
        res.status(STATUS_CODES.NOT_FOUND).json({message: error.message});
      }
    }
  };

  // DEPRECIATED - TO BE REMOVED WHEN 1.15 isnt used anymore
  //========================================================
  getTeammatesDeclarationsFromUserTeams = async (req: Request, res: Response) => {
    const userId = Number(req.query.userId);
    try {
      const teammates = await this.service.getTeammatesDeclarationsFromUserTeams(userId);
      res.send(teammates);
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(STATUS_CODES.NOT_FOUND).json({message: error.message});
      } else {
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({message: error.message});
      }
    }
  };

  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //========================================================
  getByTeamIdWithLastDeclaration = async (req: Request, res: Response) => {
    const userId = Number(req.query.userId);
    try {
      const teammates = await this.service.getByTeamIdWithLastDeclaration(userId);
      res.send(teammates);
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(STATUS_CODES.NOT_FOUND).json({message: error.message});
      } else {
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({message: error.message});
      }
    }
  };
}
