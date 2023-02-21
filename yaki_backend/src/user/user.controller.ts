import UserModel from "./user.model";
import { UserService } from "./user.service";
import { Response, Request } from "express";

export class UserController {
    service: UserService;

    constructor(service: UserService) {
        this.service = service;
    }

    checkLogin = (async (req: Request, res: Response) => {
        this.service.checkUserLoginDetails(req.body)
            .then((response) => res.send(response))
            .catch((err) => res.send(err.message))
    })
}