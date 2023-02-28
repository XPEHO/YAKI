import { Declaration } from "./declaration.interface";
import { DeclarationService } from "./declaration.service";
import { Request, Response } from 'express';


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
     * Handles an incoming HTTP POST request to create a new declaration.
     * @param req The incoming HTTP request.
     * @param res The HTTP response to be sent.
     * @returns A promise that returns nothing.
     */
    async createDeclaration(req: Request, res: Response): Promise<void> {
        const declaration: Declaration = req.body;
        try {
            const createdDeclaration = await this.declarationService.createDeclaration(declaration);
            res.status(201).json(createdDeclaration);
        } catch (error: any) {
            res.status(500).json({ message: error.message });
        }
    }
}