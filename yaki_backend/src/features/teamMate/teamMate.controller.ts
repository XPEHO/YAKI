import { TeamMateService } from "./teamMate.service";
import { Response, Request } from "express";

export class TeamMateController {
    service: TeamMateService;

    constructor(service: TeamMateService) {
        this.service = service;
    }

    getByTeamIdWithLastDeclaration = (async (req: Request, res: Response) => {
        const teamId = Number(req.query.teamId);
        this.service.getByTeamIdWithLastDeclaration(teamId)
            .then((response) => res.send(response))
            .catch((err) => res.status(500).send(err.message));
    });
}