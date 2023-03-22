import { TeamMateService } from "./teamMate.service";
import { Response, Request } from "express";

export class TeamMateController {
    service: TeamMateService;

    constructor(service: TeamMateService) {
        this.service = service;
    }

    getByTeamIdWithLastDeclaration = (async (req: Request, res: Response) => {
        const teamId = Number(req.query.captainId);
        try {
            const teamMates = await this.service.getByTeamIdWithLastDeclaration(teamId);
            res.send(teamMates);
        } catch(error: any) {
            if(error instanceof TypeError) {
                res.status(404).json({ message: error.message})
            } else {
                res.status(500).json({ message: error.message });
            }
        }
    });
}