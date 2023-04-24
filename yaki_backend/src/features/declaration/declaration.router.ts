import express, {Router} from "express";
import {authService} from "../user/authentication.service";
import {DeclarationController} from "./declaration.controller";
import {DeclarationRepository} from "./declaration.repository";
import {DeclarationService} from "./declaration.service";

/* Creating a new router object. */
const declarationRouter: Router = express.Router();

/* Creating a new instance of the DeclarationRepository class. */
const declarationRepo = new DeclarationRepository();

/* Creating a new instance of the DeclarationService class. */
const declarationService = new DeclarationService(declarationRepo);

/* Creating a new instance of the DeclarationController class. */
const declarationController = new DeclarationController(declarationService);

/* Creating a new route for the declarationRouter object. */
declarationRouter.post(
  "/declarations",
  (req, res, next) =>
    /* #swagger.parameters['declaration'] = {
                in: 'body',
                description: 'Declaration details',
                required: true,
                type: 'object',
                schema: { declarationTeamMateId: 1, declarationStatus: 'string', declarationDate: 'string' }
}
  */
    authService.verifyToken(req, res, next),
  (req, res) => {
    declarationController.createDeclaration(req, res);
  }
);

declarationRouter.get(
  "/declarations",
  (req, res, next) =>
    /*#swagger.parameters['teamMateId'] = {
                in: 'query',
                description: 'Team mate id',
                required: true,
                type: 'number',
                schema: { teamMateId: 1 }
}
  */
    authService.verifyToken(req, res, next),
  (req, res) => {
    declarationController.getDeclarationsForTeamMate(req, res);
  }
);


/* Exporting the declarationRouter object. */
export default declarationRouter;
