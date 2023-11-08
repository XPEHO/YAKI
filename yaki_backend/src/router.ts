import {TeamService} from "./features/team/team.service";
import express from "express";
import {UserController} from "./features/user/user.controller";
import {UserService} from "./features/user/user.service";
import {UserRepository} from "./features/user/user.repository";
import {TeammateRepository} from "./features/teammate/teammate.repository";
import {authService} from "./features/user/authentication.service";
import {TeammateController} from "./features/teammate/teammate.controller";
import {TeammateService} from "./features/teammate/teammate.service";
import {limiter, signInLimiter} from "./middleware/rateLimiter";
import {PasswordRepository} from "./features/password/password.repository";
import {PasswordService} from "./features/password/password.service";
import {PasswordController} from "./features/password/password.controller";
import {TeamRepository} from "./features/team/team.repository";

export const router = express.Router();

const teamRepository = new TeamRepository();
const teamService = new TeamService(teamRepository);
//TEAM MATE
const teammateRepository = new TeammateRepository();
const teammateService = new TeammateService(teammateRepository, teamService);
const teammateController = new TeammateController(teammateService);

// MULTER to handle file upload
const multer = require("multer");
const upload = multer({dest: "uploads/"});

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository);
const userController = new UserController(userService);

//PASSWORD
const passwordRepository = new PasswordRepository();
const passwordService = new PasswordService(passwordRepository);
const passwordController = new PasswordController(passwordService);

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

router.post("/register", (req, res) => userController.registerNewUser(req, res));

router.get("/users/:userId", (req, res) => {
  userController.getUserById(req, res);
});

router.post(
  "/users/:id/avatar-selection",
  upload.single("avatar"),
  (req, res, next) => authService.verifyToken(req, res, next),
  async (req, res) => userController.registerNewAvatar(req, res)
);

router.get(
  "/users/:id/personal-avatar",
  (req, res, next) => authService.verifyToken(req, res, next),
  async (req, res) => userController.getPersonalAvatarByUserId(req, res)
);

// DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
//========================================================
router.get(
  "/teammates",
  (req, res, next) =>
    /*#swagger.parameters['userId'] = {
                in: 'query',
                description: 'user id',
                required: true,
                type: 'number',
                schema: { userId: 1 }
}
  */ authService.verifyToken(req, res, next),
  async (req, res) => teammateController.getByTeamIdWithLastDeclaration(req, res)
);

router.get(
  "/users-with-declaration",
  (req, res, next) =>
    /*#swagger.parameters['userId'] = {
                in: 'query',
                description: 'user id',
                required: true,
                type: 'number',
                schema: { userId: 1 }
}
  */ authService.verifyToken(req, res, next),
  async (req, res) => teammateController.getTeammatesDeclarationsFromUserTeams(req, res)
);

router.post(
  "/password/change",
  (req, res, next) => authService.verifyToken(req, res, next),
  async (req, res) => passwordController.changePassword(req, res)
);

router.post("/password/forgot", async (req, res) =>
  /* #swagger.parameters['login forgotPassword'] = {
router.post("/forgot", async (req, res) =>
  /* #swagger.parameters['password forgot'] = {
                in: 'body',
                description: 'email',
                required: true,
                type: 'object',
                schema: { email: 'string' }
  */
  passwordController.forgotPassword(req, res)
);
