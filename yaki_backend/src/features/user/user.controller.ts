import {UserService} from "./user.service";
import {Response, Request} from "express";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";

import {AvatarEnum} from "./avatar.enum";
import PictureProcessing from "../../utils/PictureProcessing";

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

  getPersonalAvatarByUserId = async (req: Request, res: Response) => {
    const userId = Number(req.params.id);

    try {
      const personalAvatar: Buffer | string | null = await this.service.getPersonalAvatarByUserId(userId);

      if (personalAvatar instanceof Buffer) {
        const filePath = PictureProcessing.byteaToImage(personalAvatar);
        res.status(200).sendFile(filePath);
        return;
      } else {
        res.status(204).json({message: personalAvatar});
        return;
      }
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

    const avatarChoices: string[] = Object.values(AvatarEnum);
    if (!avatarChoices.includes(avatarReference)) {
      throw new TypeError(`${avatarReference} isn't an existing avatar choice`);
    }

    try {
      if (avatarReference !== AvatarEnum.USERPICTURE) {
        const updatedDefaultAvatarReference = await this.service.setDefaultAvatarChoice(userId, avatarReference);
        // if getting an image along with the default avatar choice, delete the image as its not meant to be saved in the database
        if (file !== undefined) PictureProcessing.deleteUploadedFile(file);
        res.status(200).json({message: updatedDefaultAvatarReference});

        // if the avatar is a user picture, save it in the database
      } else if (avatarReference === AvatarEnum.USERPICTURE && file !== undefined) {
        const registeredAvatar = await this.service.registerNewAvatar(userId, file, avatarReference);

        //delete the uploaded files after saving in databases
        PictureProcessing.deleteUploadedFile(file);

        const filePath = PictureProcessing.byteaToImage(registeredAvatar.avatarBlob);
        res.status(200).sendFile(filePath);
      } else {
        throw new TypeError("No file uploaded");
      }
    } catch (error: any) {
      if (error instanceof TypeError) {
        res.status(400).json({message: error.message});
      } else {
        res.status(500).json({message: error.message});
      }
    }
  };
}
