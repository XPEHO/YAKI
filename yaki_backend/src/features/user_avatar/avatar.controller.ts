import {Response, Request} from "express";

import {AvatarEnum} from "../user_avatar/avatar.enum";
import PictureProcessing from "../../utils/PictureProcessing";
import {AvatarService} from "./avatar.service";
import {STATUS_CODES} from "../../utils/statusCode.enum";

export class AvatarController {
  avatarService: AvatarService;

  constructor(avatarService: AvatarService) {
    this.avatarService = avatarService;
  }

  getAvatarByUserId = async (req: Request, res: Response) => {
    const userId = Number(req.params.id);

    try {
      const personalAvatar: Buffer | string | null = await this.avatarService.getAvatarByUserId(userId);

      if (personalAvatar instanceof Buffer) {
        const byteArray = [...personalAvatar];
        //const filePath = PictureProcessing.byteaToImage(personalAvatar);
        return this.sendSuccessResponse(res, STATUS_CODES.OK, byteArray);
      } else if (typeof personalAvatar === "string") {
        return this.sendSuccessResponse(res, STATUS_CODES.OK, {message: personalAvatar});
      } else {
        return this.sendSuccessResponse(res, STATUS_CODES.NOT_FOUND, {
          message: "The user don't have any avatar selected",
        });
      }
    } catch (error: any) {
      console.error(error);
      return this.sendErrorResponse(res, STATUS_CODES.INTERNAL_SERVER_ERROR, error.message);
    }
  };

  /**
   * Register in the database a new avatar for a user
   * @param req
   * @param res
   * @returns
   */
  setAvatarByUserId = async (req: Request, res: Response): Promise<void> => {
    const userId = Number(req.params.id);
    const avatarReference = req.body.avatarName;
    const file: Express.Multer.File | undefined = req.file;

    const avatarChoices: string[] = Object.values(AvatarEnum);
    if (!avatarChoices.includes(avatarReference)) {
      return this.sendErrorResponse(res, STATUS_CODES.NOT_FOUND, `${avatarReference} is an invalid  option`);
    }

    let isSettingDefaultAvatar: boolean;

    try {
      // default avatar
      if (avatarReference !== AvatarEnum.USERPICTURE) {
        isSettingDefaultAvatar = true;

        const defaultAvatarReference = await this.avatarService.setAvatarByUserId(
          userId,
          avatarReference,
          null,
          isSettingDefaultAvatar
        );
        // if getting an image along with the default avatar choice, delete the image as its not meant to be saved in the database
        if (file !== undefined) PictureProcessing.deleteUploadedFile(file);
        return this.sendSuccessResponse(res, STATUS_CODES.OK, {message: defaultAvatarReference?.avatarReference});
      }

      if (avatarReference === AvatarEnum.USERPICTURE && file !== undefined) {
        isSettingDefaultAvatar = false;

        const customAvatar = await this.avatarService.setAvatarByUserId(
          userId,
          avatarReference,
          file,
          isSettingDefaultAvatar
        );
        //delete the uploaded files after saving in databases
        PictureProcessing.deleteUploadedFile(file);
        const byteArray = [...customAvatar.avatarBlob];
        return this.sendSuccessResponse(res, STATUS_CODES.OK, byteArray);
      }

      return this.sendErrorResponse(res, STATUS_CODES.NOT_FOUND, "no file was uploaded");
    } catch (error: any) {
      const statusCode = error.message.includes("file") ? STATUS_CODES.NOT_FOUND : STATUS_CODES.INTERNAL_SERVER_ERROR;
      return this.sendErrorResponse(res, statusCode, error.message);
    }
  };

  sendSuccessResponse(res: Response, statusCode: number, message: string | Buffer | number[] | {message: string}) {
    res.status(statusCode).send(message);
  }
  sendErrorResponse(res: Response, statusCode: number, errorMessage: string) {
    res.status(statusCode).json({message: errorMessage});
  }
}
