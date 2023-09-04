import { UserService } from "./user.service";
import { Response, Request } from "express";
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
        res.status(417).json({ message: error.message });
        //catch emails error
      } else {
        // catch server errors
        res.status(400).json({ message: error.message });
      }
    }
  };

  resetPassword = async (req: Request, res: Response) => {
    try {
      const { email, newPassword } = req.body;
      const success = await this.service.resetPassword(email, newPassword);
      if (success) {
        res.status(200).json({ message: "Password reset successful" });
      } else {
        res.status(400).json({ message: "Failed to reset password" });
      }
    } catch (error: any) {
      res.status(400).json({ message: error.message });
    }
  };
}
