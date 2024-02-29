import express from "express";
import { TeamService } from "./features/team/team.service";
import { UserController } from "./features/user/user.controller";
import { UserService } from "./features/user/user.service";
import { UserRepository } from "./features/user/user.repository";
import { TeammateRepository } from "./features/teammate/teammate.repository";
import { authService } from "./features/user/authentication.service";
import { TeammateController } from "./features/teammate/teammate.controller";
import { TeammateService } from "./features/teammate/teammate.service";
import { limiter, signInLimiter } from "./middleware/rateLimiter";
import { PasswordRepository } from "./features/password/password.repository";
import { PasswordService } from "./features/password/password.service";
import { PasswordController } from "./features/password/password.controller";
import { TeamRepository } from "./features/team/team.repository";
import { AvatarService } from "./features/user_avatar/avatar.service";
import { AvatarRepository } from "./features/user_avatar/avatar.repository";
import { AvatarController } from "./features/user_avatar/avatar.controller";

export const router = express.Router();

const teamRepository = new TeamRepository();
const teamService = new TeamService(teamRepository);

//USER AVATAR
const avatarRepository = new AvatarRepository();
const avatarServiece = new AvatarService(avatarRepository);
const avatarController = new AvatarController(avatarServiece);

//TEAM MATE
const teammateRepository = new TeammateRepository();
const teammateService = new TeammateService(
  teammateRepository,
  teamService,
  avatarServiece
);
const teammateController = new TeammateController(teammateService);

// MULTER to handle file upload
const multer = require("multer");
const upload = multer({ dest: "uploads/" });

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository);
const userController = new UserController(userService);

//PASSWORD
const passwordRepository = new PasswordRepository();
const passwordService = new PasswordService(passwordRepository, userService);
const passwordController = new PasswordController(passwordService);

router.get("/verify-token", authService.verifyToken, (_, res) =>
  res.status(200).send("Token is valid")
);

router.post("/login", signInLimiter, async (req, res) => {
  /* #swagger.parameters['Login'] = {
                in: 'body',
                description: 'Login details',
                required: true,
                type: 'object',
                schema: { login: 'string', password: 'string' }
} */
  try {
    await userController.checkLogin(req, res);
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "An error occurred" });
  }
});

router.use(limiter);

router.post("/register", async (req, res) => {
  try {
    await userController.registerNewUser(req, res);
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "An error occurred" });
  }
});

router.post("/register", async (req, res) => {
  try {
    await userController.registerNewUser(req, res);
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "An error occurred" });
  }
});

router.get("/users/:userId", async (req, res) => {
  try {
    await userController.getUserById(req, res);
  } catch (error) {
    res.status(500).send(error);
  }
});

// upload.single("avatar") is the multer middleware to handle the file upload
router.post(
  "/users/:id/avatar-selection",
  upload.single("avatar"),
  (req, res, next) => authService.verifyToken(req, res, next).catch(next),
  async (req, res) => {
    try {
      await avatarController.setAvatarByUserId(req, res);
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: "An error occurred" });
    }
  }
);

router.get(
  "/users/:id/personal-avatar",
  (req, res, next) => authService.verifyToken(req, res, next).catch(next),
  async (req, res) => {
    try {
      await avatarController.getAvatarByUserId(req, res);
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: "An error occurred" });
    }
  }
);

router.post(
  "/password/change",
  (req, res, next) => authService.verifyToken(req, res, next),
  async (req, res) => {
    try {
      await passwordController.changePassword(req, res);
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: "An error occurred" });
    }
  }
);

router.post("/password/forgot", async (req, res) => {
  /* #swagger.parameters['login forgotPassword'] = {
router.post("/forgot", async (req, res) =>
  /* #swagger.parameters['password forgot'] = {
                in: 'body',
                description: 'email',
                required: true,
                type: 'object',
                schema: { email: 'string' }
  */
  try {
    await passwordController.forgotPassword(req, res);
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "An error occurred" });
  }
});

router.get(
  "/users-declaration-and-avatar",
  (req, res, next) =>
    /*#swagger.parameters['userId'] = {
                in: 'query',
                description: 'user id',
                required: true,
                type: 'number',
                schema: { userId: 1 }
}
  */
    authService.verifyToken(req, res, next).catch(next),
  async (req, res) => {
    try {
      await teammateController.getTeammatesDeclarationsAndAvatarFromUserTeams(
        req,
        res
      );
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: "An error occurred" });
    }
  }
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
  */
    authService.verifyToken(req, res, next).catch(next),
  async (req, res) => {
    try {
      await teammateController.getByTeamIdWithLastDeclaration(req, res);
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: "An error occurred" });
    }
  }
);

// DEPRECIATED - TO BE REMOVED WHEN 1.15 isnt used anymore
//========================================================
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
  */
    authService.verifyToken(req, res, next).catch(next),
  async (req, res) => {
    try {
      await teammateController.getTeammatesDeclarationsFromUserTeams(req, res);
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: "An error occurred" });
    }
  }
);
