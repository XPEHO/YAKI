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
        const createdFullDayDeclaration = await this.declarationService.createDeclaration(declarationReqBody);
        res.status(201).json(createdFullDayDeclaration);
      }

      if (mode === "halfDay") {
        const createdHalfDayDeclarations = await this.declarationService.createHalfDayDeclarations(declarationReqBody);
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
  async getDeclarationsForTeamMate(req: Request, res: Response) {
    const teamMateId = Number(req.query.teamMateId);
    try {
      const declarations = await this.declarationService.getDeclarationForTeamMate(teamMateId);
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

  /**
   * Updating the declaration status.
   * @param req The incoming HTTP request.
   * @param res The HTTP response to be sent.
   */
  async updateDeclarationStatus(req: Request, res: Response) {
    const declarationId = parseInt(req.params.declarationId);
    const declaration: DeclarationDtoIn[] = req.body;
    try {
      await this.declarationService.updateDeclarationStatus(declarationId, declaration);
      res.status(200).json(declaration);
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
