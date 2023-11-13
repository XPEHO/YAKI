import {UserService} from "./user.service";
import {Response, Request} from "express";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";

export class UserController {
  service: UserService;

  constructor(service: UserService) {
    this.service = service;
  }

  /**
   * Send login details from the front to be checked
   */
  checkLogin = async (req: Request, res: Response) => {
    console.log("Login informations", req.body.login, "password : -hidden-");
    this.service
      .checkUserLoginDetails(req.body)
      .then((response) => res.send(response))
      .catch((err) => res.status(204).send(err.message));
  };

  registerNewUser = async (req: Request, res: Response) => {
    try {
      const response = await this.service.registerUser(req.body);
      res.send(response);
    } catch (error: any) {
      if (error instanceof EmailAlreadyExistsError) {
        res.status(417).json({message: error.message});
        //catch emails error
      } else {
        // catch server errors
        res.status(400).json({message: error.message});
      }
    }
  };

  getUserById = async (req: Request, res: Response) => {
    const userId = Number(req.params.userId);
    try {
      const response = await this.service.getUserById(userId);
      res.send(response);
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(404).json({message: error.message});
      } else {
        res.status(500).json({message: error.message});
      }
    }
  };
}
