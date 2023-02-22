import { Declaration } from "./declaration.interface";
import { DeclarationService } from "./declaration.service";
import { Request, Response } from 'express';


export class DeclarationController {
    constructor(private declarationService: DeclarationService) {}

    async createDeclaration(req: Request, res: Response) {
        const declaration = req.body;
        const newDeclaration = await this.declarationService.createDeclaration(
          declaration
        );
        res.status(201).json(newDeclaration);
        console.log(newDeclaration);
        
      }
    // private declarationService: DeclarationService;

    // constructor(declarationService: DeclarationService) {
    //     this.declarationService = new DeclarationService();
    // }
    

    // async createDeclaration(req: Request, res: Response): Promise<void> {
    //     const declaration: Declaration = req.body;
    //     // try {
    //         const createdDeclaration = await this.declarationService.createDeclaration(declaration);
    //         res.status(201).json(createdDeclaration);
    //     // } catch (error: any) {
    //     //     res.status(500).json({ message: error.message });
    //     // }
    // }

    // async findDeclarationByTeammate(req: Request, res: Response): Promise<void> {
    //     const teamMateId: number = parseInt(req.params.teamMateId);
    //     try {
    //         const declarations = await this.declarationService.findDeclarationByTeammate(teamMateId);
    //         res.status(200).json(declarations);
    //     } catch (error: any) {
    //         res.status(500).json({ message: error.message })
    //     }
    // }
}