import { Declaration } from "./declaration.interface";
import { DeclarationService } from "./declaration.service";
import { Request, Response } from 'express';


class DeclarationController {
    private declarationService: DeclarationService;
  
    constructor() {
      this.declarationService = new DeclarationService();
    }
  
    async saveDeclaration(req: Request, res: Response): Promise<void> {
      const declaration: Declaration = req.body;
      const savedDeclaration = await this.declarationService.save(declaration);
      res.status(201).json(savedDeclaration);
    }
  
    async getDeclaration(req: Request, res: Response): Promise<void> {
      const id = Number(req.params.id);
      const declaration = await this.declarationService.findById(id);
      res.json(declaration);
    }
  
    async getDeclarationsByTeammate(req: Request, res: Response): Promise<void> {
      const idTeammate = Number(req.params.idTeammate);
      const declarations = await this.declarationService.findByTeammate(idTeammate);
      res.json(declarations);
    }
  }