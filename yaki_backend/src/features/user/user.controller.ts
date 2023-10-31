import {UserService} from "./user.service";
import {Response, Request} from "express";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";

import fs from "fs";
import YakiUtils from "../../utils/yakiUtils";

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

  /**
   * Register in the database a new avatar for a user
   * @param req
   * @param res
   * @returns
   */
  registerNewAvatar = async (req: Request, res: Response): Promise<void> => {
    const userId = Number(req.params.id);
    const avatarReference = req.body.avatarName;

    const file: Express.Multer.File | undefined = req.file;
    if (file === undefined) {
      res.status(400).json({message: "No file uploaded"});
      return;
    }

    try {
      const registeredAvatar = await this.service.registerNewAvatar(userId, file, avatarReference);

      //delete the uploaded files after saving in databases
      fs.unlink(file.path, (err) => {
        if (err) {
          console.error("Error deleting file:", err);
        }
      });

      const filePath = YakiUtils.byteaToPicture(registeredAvatar);

      res.status(200).sendFile(filePath, (err) => {
        if (err) {
          console.error("Error sending file:", err);
        } else {
          //delete the file after sending it
          fs.unlink(filePath, (err) => {
            if (err) {
              console.error("Error deleting file:", err);
            }
          });
        }
      });
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(400).json({message: error.message});
      } else {
        res.status(500).json({message: error.message});
      }
    }
  };
}
