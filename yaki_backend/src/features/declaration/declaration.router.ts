import express, { Router } from "express";
import { DeclarationController } from "./declaration.controller";
import { DeclarationRepository } from "./declaration.repository";
import { DeclarationService } from "./declaration.service";

/* Creating a new router object. */
const declarationRouter: Router = express.Router();

/* Creating a new instance of the DeclarationRepository class. */
const declarationRepo = new DeclarationRepository();

/* Creating a new instance of the DeclarationService class. */
const declarationService = new DeclarationService(declarationRepo);

/* Creating a new instance of the DeclarationController class. */
const declarationController = new DeclarationController(declarationService);


/* Creating a new route for the declarationRouter object. */
declarationRouter.post("/declarations", (req, res) => { declarationController.createDeclaration(req, res) })

/* Exporting the declarationRouter object. */
export default declarationRouter;