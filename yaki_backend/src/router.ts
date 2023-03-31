import express from 'express';
import { UserController } from './features/user/user.controller';
import { UserService } from './features/user/user.service';
import { UserRepository } from './features/user/user.repository';
import { CaptainRepository } from './features/captain/captain.repository';
import { CaptainService } from './features/captain/captain.service';
import { TeamMateRepository } from './features/teamMate/teamMate.repository';
import { TeamMateService } from './features/teamMate/teamMate.service';
import { authService } from './features/user/authentication.service';
import { CaptainController } from './features/captain/captain.controller';
import { TeamMateController } from './features/teamMate/teamMate.controller';
import { TeamRepository } from './features/team/team.repository';
import { TeamService } from './features/team/team.service';

export const router = express.Router();

// TEAM
const teamRepository = new TeamRepository();
const teamService = new TeamService(teamRepository);

//TEAM MATE
const teamMateRepository = new TeamMateRepository();
const teamMateService = new TeamMateService(teamMateRepository, teamService);
const teamMateController = new TeamMateController(teamMateService);

//CAPTAIN
const captainRepository = new CaptainRepository();
const captainService = new CaptainService(captainRepository);
const captainController = new CaptainController(captainService);

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository);
const userController = new UserController(userService);

router.post('/login', (req, res) =>
  /* #swagger.parameters['obj'] = {
                in: 'body',
                description: 'Login details',
                required: true,
                type: 'object',
                schema: { login: 'string', password: 'string' }
} */
  userController.checkLogin(req, res)
);
router.get(
  '/captains',
  (req, res, next) => authService.verifyToken(req, res, next),
  (_, res) => captainController.getAll(_, res)
);

router.get(
  '/teamMates',
  (req, res, next) => authService.verifyToken(req, res, next),
  async (req, res) =>
    teamMateController.getByTeamIdWithLastDeclaration(req, res)
);
