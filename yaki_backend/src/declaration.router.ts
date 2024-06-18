import express, {Router} from "express";
import {authService} from "./features/user/authentication.service";
import {DeclarationController} from "./features/declaration/declaration.controller";
import {DeclarationRepository} from "./features/declaration/declaration.repository";
import {DeclarationService} from "./features/declaration/declaration.service";
import {limiter} from "./middleware/rateLimiter";

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
      console.error(error);
      res.status(500).send({message: "An error occurred"});
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
      declarationController.getLatestDeclarationByUserID(req, res);
    } catch (error) {
      console.error(error);
      res.status(500).send({message: "An error occurred"});
    }
  }
);

declarationRouter.get(
  "/declarations/declaredDays",
  (req, res, next) => {
    if (req.query.userId == null) {
      return res.status(400).send({message: "Missing required query parameter 'userId'"})
    }
    if (isNaN(parseInt(req.query.userId as string))) {
      return res.status(400).send({message: "Invalid userId"})
    }
    return authService.verifyToken(req, res, next)
  },
  async (req, res) => {
  /**
   * @swagger
   * declarations/declaredDays:
   *   get:
   *     summary: Get declared days by user ID
   *     description: Returns a list of declared days for a specific user.
   *     tags:
   *       - Declarations
   *     parameters:
   *       - in: query
   *         name: userId
   *         description: The ID of the user to retrieve declared days for.
   *         required: true
   *         schema:
   *           type: integer
   *           minimum: 1
   *     responses:
   *       200:
   *         description: OK. Returns a list of declared days for the user. Returns [] if the user doesn't exist.
   *         content:
   *           application/json:
   *             schema:
   *               type: array
   *               items:
   *                 $ref: '#/components/schemas/DeclaredDay'
   *       400:
   *         description: Bad Request. Missing required query parameter 'userId'.
   *         content:
   *           application/json:
   *             schema:
   *               type: object
   *               properties:
   *                 message:
   *                   type: string
   *                   description: The error message.
   *       500:
   *         description: Internal Server Error.
   *         content:
   *           application/json:
   *             schema:
   *               type: object
   *               properties:
   *                 message:
   *                   type: string
   *                   description: The error message.
   */

    try {
      declarationController.getDeclaredDaysByUserId(req, res)
    } catch(error) {
      console.error(error)
      res.status(500).send({message: "An error occurred"});
    }
  }
)

/* Exporting the declarationRouter object. */
export default declarationRouter;
