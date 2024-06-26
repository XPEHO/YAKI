import {DeclarationService} from "./declaration.service";
import {Request, Response} from "express";
import {DeclarationDtoIn} from "./declaration.dtoIn";

export class DeclarationController {
  private declarationService: DeclarationService;

  /**
   * Creates a new instance of DeclarationController.
   * @param declarationService The DeclarationService instance to be used by this controller.
   */
  constructor(declarationService: DeclarationService) {
    this.declarationService = declarationService;
  }

  /**
   * Handles an incoming HTTP POST request to create a new declaration,
   * Or create the half days declarations depending of the "mode" request params.
   * @param req The incoming HTTP request.
   * @param res The HTTP response to be sent.
   * @returns A promise that returns nothing.
   */
  async createDeclaration(req: Request, res: Response): Promise<void> {
    const mode = req.query.mode;
    const declarationReqBody: DeclarationDtoIn[] = req.body;

    try {
      if (mode === "fullDay") {
        const createdFullDayDeclaration = await this.declarationService.createDeclaration(
          declarationReqBody
        );
        res.status(201).json(createdFullDayDeclaration);
      }

      if (mode === "halfDay") {
        const createdHalfDayDeclarations =
          await this.declarationService.createHalfDayDeclarations(declarationReqBody);
        res.status(201).json(createdHalfDayDeclarations);
      }
    } catch (error: any) {
      if (error instanceof TypeError) {
        // catch bad request errors
        res.status(400).json({message: error.message});
      } else {
        // catch server errors
        res.status(500).json({message: error.message});
      }
    }
  }

  /**
   * It gets the declaration for a team mate.
   * @param {Request} req - Request - the request object
   * @param {Response} res - Response - the response object
   */
  async getLatestDeclarationByUserID(req: Request, res: Response) {
    const userId = Number(req.query.userId);
    try {
      const declarations = await this.declarationService.getLatestDeclarationByUserId(userId);
      res.status(200).json(declarations);
    } catch (error: any) {
      if (error instanceof TypeError) {
        // catch not found errors
        res.status(404).json({message: error.message});
      } else {
        // catch server errors
        res.status(500).json({message: error.message});
      }
    }
  }

  async getDeclaredDaysByUserId(req: Request, res: Response) {
    const userId = Number(req.query.userId);
    try {
      const days = await this.declarationService.getDeclaredDaysByUserId(userId)
      res.status(200).json(days);
    } catch (error: any) {
      if (error instanceof TypeError) {
        // catch not found errors
        res.status(404).json({message: error.message});
      } else {
        // catch server errors
        res.status(500).json({message: error.message});
      }
    }
  }
}
