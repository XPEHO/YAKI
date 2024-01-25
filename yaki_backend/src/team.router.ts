import express, {Router} from "express";
import {TeamController} from "./features/team/team.controller";
import {TeamRepository} from "./features/team/team.repository";
import {TeamService} from "./features/team/team.service";
import {authService} from "./features/user/authentication.service";
import {limiter} from "./middleware/rateLimiter";

// Creating a new router object.
const teamRouter: Router = express.Router();

// Creating a new instance of the TeamRepository class.
const teamRepository = new TeamRepository();

// Creating a new instance of the TeamService class.
const teamService = new TeamService(teamRepository);

// Creating a new instance of the TeamController class.
const teamController = new TeamController(teamService);
teamRouter.use(limiter);
// Creating a new route for the teamRouter object.
teamRouter.get(
  "/teams",
  (req, res, next) => authService.verifyToken(req, res, next),
  (req, res) => teamController.getTeamByTeammateId(req, res)
);

teamRouter.get(
  "/teams-logo",
  (req, res, next) => authService.verifyToken(req, res, next),
  (req, res) => teamController.getTeamImageByTeamsId(req, res)
);

export default teamRouter;
