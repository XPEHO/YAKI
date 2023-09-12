import { PasswordService } from "./password.service";
import { PasswordForgottenDtoIn } from "./passwordForgotten.dtoIn";
import { PasswordChangeDtoIn } from "./passwortChange.dtoIn";

export class PasswordController {
  private passwordService: PasswordService;

  constructor(passwordService: PasswordService) {
    this.passwordService = passwordService;
  }

  // req / res type
  //    req: Request<{}, any, any, ParsedQs, Record<string, any>>,
  // _: Response<any, Record<string, any>, number>;
  async changePassword(req: any, res: any): Promise<void> {
    if (req.body === undefined || req.body === null)
      throw new Error("No data provided");
    const passwordChange: PasswordChangeDtoIn = req.body;
    try {
      const response = await this.passwordService.changePassword(
        passwordChange
      );
      if (response === true) {
        res.status(200).json({ message: true });
      } else {
        res.status(401).json({ message: false });
      }
    } catch (error: any) {
      res.status(418).json({ message: error.message });
    }
  }

  async forgotPassword(req: any, res: any): Promise<void> {
    console.warn("controller", req.body);
    if (req.body === undefined || req.body === null)
      throw new Error("Body is Empty");
    const passwordForgot: PasswordForgottenDtoIn = req.body;
    try {
      const response = await this.passwordService.forgotPassword(
        passwordForgot
      );
      if (response === true) {
        res.status(200).json({ message: true });
      } else {
        res.status(404).json({ message: false });
      }
    } catch (error: any) {
      res.status(418).json({ message: error.message });
    }
  }
}
