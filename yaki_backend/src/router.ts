import express from "express";
import {UserController} from "./features/user/user.controller";
import {UserService} from "./features/user/user.service";
import {UserRepository} from "./features/user/user.repository";
import {TeammateRepository} from "./features/teammate/teammate.repository";
import {TeammateService} from "./features/teammate/teammate.service";
import {authService} from "./features/user/authentication.service";

import {TeammateController} from "./features/teammate/teammate.controller";
import {TeamRepository} from "./features/team/team.repository";
import {TeamService} from "./features/team/team.service";

export const router = express.Router();

// TEAM
const teamRepository = new TeamRepository();
const teamService = new TeamService(teamRepository);

//TEAM MATE
const teamMateRepository = new TeammateRepository();
const teamMateService = new TeammateService(teamMateRepository, teamService);
const teamMateController = new TeammateController(teamMateService);

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository);
const userController = new UserController(userService);

router.post("/login", (req, res) =>
  /* #swagger.parameters['Login'] = {
                in: 'body',
                description: 'Login details',
                required: true,
                type: 'object',
                schema: { login: 'string', password: 'string' }
} */
  userController.checkLogin(req, res)
);

router.post("/register", (req, res) => userController.registerNewUser(req, res));

router.get(
  "/teamMates",
  (req, res, next) =>
    /*#swagger.parameters['captainId'] = {
                in: 'query',
                description: 'Captain id',
                required: true,
                type: 'number',
                schema: { captainId: 1 }
}
  */ authService.verifyToken(req, res, next),
  async (req, res) => teamMateController.getByTeamIdWithLastDeclaration(req, res)
);
