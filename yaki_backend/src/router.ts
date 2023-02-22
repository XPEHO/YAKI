import express, { Router } from "express";
import { DeclarationController } from "./features/declaration/daclaration.controller";
import { DeclarationRepository } from "./features/declaration/declaration.repository";
import { DeclarationService } from "./features/declaration/declaration.service";
// import { Declaration } from './declaration.interface';


// const declarationRepo = new DeclarationRepository();
// const declarationService = new DeclarationService(declarationRepo);
 const declarationService = new DeclarationService();

const declarationController = new DeclarationController(declarationService);
// const serviceDeclaration = new DeclarationService(Declaration)


const router: Router = express.Router();

router.post("/declarations", declarationController.createDeclaration)

export default router;