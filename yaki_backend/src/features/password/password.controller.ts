import {DataError, DatabaseError} from "../../errors/dataOrDataBaseError";
import {STATUS_CODES} from "../../utils/statusCode.enum";
import {PasswordService} from "./password.service";
import {PasswordForgottenDtoIn} from "./passwordForgotten.dtoIn";
import {PasswordChangeDtoIn} from "./passwortChange.dtoIn";

export class PasswordController {
  private passwordService: PasswordService;

  constructor(passwordService: PasswordService) {
    this.passwordService = passwordService;
  }

  // req / res type
  //    req: Request<{}, any, any, ParsedQs, Record<string, any>>,
  // _: Response<any, Record<string, any>, number>;
  async changePassword(req: any, res: any): Promise<void> {
    if (!req.body) throw new Error("No data provided");
    const passwordChange: PasswordChangeDtoIn = req.body;
    try {
      const response = await this.passwordService.changePassword(passwordChange);
      if (response) {
        res.status(STATUS_CODES.OK).json({message: true});
      }
    } catch (error: any) {
      if (error instanceof DataError) {
        res.status(STATUS_CODES.BAD_REQUEST).json({message: error.message});
      } else if (error instanceof DatabaseError) {
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({message: error.message});
      } else {
        res.status(418).json({message: error.message});
      }
    }
  }

  /**
   * This function handles the forgot password request.
   *
   * @param req The request object, containing the user details in the body.
   * @param res The response object, used to send the response back to the client.
   */
  async forgotPassword(req: any, res: any): Promise<void> {
    console.warn("controller", req.body);
    if (req.body === undefined || req.body === null) throw new Error("Body is Empty");
    const passwordForgot: PasswordForgottenDtoIn = req.body;
    try {
      const response = await this.passwordService.forgotPassword(passwordForgot);
      if (response === true) {
        res.status(STATUS_CODES.OK).json({message: true});
      } else {
        res.status(STATUS_CODES.NOT_FOUND).json({message: false});
      }
    } catch (error: any) {
      res.status(418).json({message: error.message});
    }
  }
}
