import {PasswordService} from "./password.service";
import {PasswordChangeDtoIn} from "./passwordChange.dtoIn";

export class PasswordController {
  private passwordService: PasswordService;

  constructor(passwordService: PasswordService) {
    this.passwordService = passwordService;
  }

  // req / res type
  //    req: Request<{}, any, any, ParsedQs, Record<string, any>>,
  // _: Response<any, Record<string, any>, number>;
  async changePassword(req: any, res: any): Promise<void> {
    if (req.body === undefined || req.body === null) throw new Error("No data provided");

    const passwordChange: PasswordChangeDtoIn = req.body;
    try {
      this.passwordService.changePassword(passwordChange);
      res.status(200);
    } catch (error: any) {
      res.status(401).json({message: error.message});
    }
  }
}
