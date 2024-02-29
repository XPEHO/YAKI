import express, { Router } from "express";
import { authService } from "./features/user/authentication.service";
import { DeclarationController } from "./features/declaration/declaration.controller";
import { DeclarationRepository } from "./features/declaration/declaration.repository";
import { DeclarationService } from "./features/declaration/declaration.service";
import { limiter } from "./middleware/rateLimiter";

/* Creating a new router object. */
const declarationRouter: Router = express.Router();

/* Creating a new instance of the DeclarationRepository class. */
const declarationRepo = new DeclarationRepository();

/* Creating a new instance of the DeclarationService class. */
const declarationService = new DeclarationService(declarationRepo);

/* Creating a new instance of the DeclarationController class. */
const declarationController = new DeclarationController(declarationService);
declarationRouter.use(limiter);

/* Creating a new route for the declarationRouter object. */
declarationRouter.post(
  "/declarations",
  (req, res, next) =>
    /* #swagger.parameters['declaration'] = {
                in: 'body',
                description: 'Declaration details',
                required: true,
                type: 'object',
                schema: { declarationTeammateId: 1, declarationStatus: 'string', declarationDate: 'string' }
}
  */
    authService.verifyToken(req, res, next),
  async (req, res) => {
    try {
      declarationController.createDeclaration(req, res);
    } catch (error) {
      res.status(500).send(error);
    }
  }
);

declarationRouter.get(
  "/declarations",
  (req, res, next) =>
    /*#swagger.parameters['teammateId'] = {
                in: 'query',
                description: 'Teammate id',
                required: true,
                type: 'number',
                schema: { teammateId: 1 }
}
  */
    authService.verifyToken(req, res, next),
  async (req, res) => {
    try {
      declarationController.getDeclarationsForTeammate(req, res);
    } catch (error) {
      res.status(500).send(error);
    }
  }
);

/* Exporting the declarationRouter object. */
export default declarationRouter;
