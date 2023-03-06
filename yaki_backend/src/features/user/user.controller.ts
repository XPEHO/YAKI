import { UserService } from "./user.service";
import { Response, Request } from "express";

export class UserController {
    service: UserService;

    constructor(service: UserService) {
        this.service = service;
    }

    /**
     * Send login details from the front to be checked
     */
    checkLogin = (async (req: Request, res: Response) => {
        
        this.service.checkUserLoginDetails(req.body)
            .then((response) => res.send(response))
            .catch((err) => res.status(204).send(err.message))
    })
}