import { CaptainService } from "./captain.service";
import { Response, Request } from "express";

export class CaptainController {

    captainService: CaptainService

    constructor(captainService: CaptainService) {
        this.captainService = captainService;
    }

    getAll = (async (req: Request, res: Response) => {
        const captains = await this.captainService.getAll();
        res.send(captains);
    })
}