import express from "express";
import {UserController} from "./features/user/user.controller";
import {UserService} from "./features/user/user.service";
import {UserRepository} from "./features/user/user.repository";
import {TeammateRepository} from "./features/teammate/teammate.repository";
import {authService} from "./features/user/authentication.service";

import {TeammateController} from "./features/teammate/teammate.controller";
import {TeamRepository} from "./features/team/team.repository";
import {TeamService} from "./features/team/team.service";
import {TeammateService} from "./features/teammate/teammate.service";
import {limiter, signInLimiter} from "./middleware/rateLimiter";
import {PasswordRepository} from "./features/password/password.repository";
import {PasswordService} from "./features/password/password.service";
import {PasswordController} from "./features/password/password.controller";

export const router = express.Router();

// TEAM
const teamRepository = new TeamRepository();
const teamService = new TeamService(teamRepository);

//TEAM MATE
const teammateRepository = new TeammateRepository();
const teammateService = new TeammateService(teammateRepository, teamService);
const teammateController = new TeammateController(teammateService);

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository);
const userController = new UserController(userService);

router.post("/login", signInLimiter, (req, res) =>
  /* #swagger.parameters['Login'] = {
                in: 'body',
                description: 'Login details',
                required: true,
                type: 'object',
                schema: { login: 'string', password: 'string' }
} */
  userController.checkLogin(req, res)
);
router.use(limiter);
router.post("/register", (req, res) => userController.registerNewUser(req, res));

router.get(
  "/teammates",
  (req, res, next) =>
    /*#swagger.parameters['captainId'] = {
                in: 'query',
                description: 'Captain id',
                required: true,
                type: 'number',
                schema: { captainId: 1 }
}
  */ authService.verifyToken(req, res, next),
  async (req, res) => teammateController.getByTeamIdWithLastDeclaration(req, res)
);

const passwordRepository = new PasswordRepository();
const passwordService = new PasswordService(passwordRepository);
const passwordController = new PasswordController(passwordService);

router.post(
  "/password/change",
  (req, res, next) => authService.verifyToken(req, res, next),
  async (req, res) => passwordController.changePassword(req, res)
);
