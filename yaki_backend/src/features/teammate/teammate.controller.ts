import { TeammateService as TeammateService } from './teammate.service';
import { Response, Request } from 'express';

export class TeammateController {
  service: TeammateService;

  constructor(service: TeammateService) {
    this.service = service;
  }

  getByTeamIdWithLastDeclaration = async (req: Request, res: Response) => {
    const teamId = Number(req.query.teamId);
    try {
      const teammates = await this.service.getByTeamIdWithLastDeclaration(
        teamId
      );
      res.send(teammates);
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(404).json({ message: error.message });
      } else {
        res.status(500).json({ message: error.message });
      }
    }
  };
}
