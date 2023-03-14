import express from 'express'
import { UserController } from './features/user/user.controller'
import { UserService } from './features/user/user.service'
import { UserRepository } from './features/user/user.repository'
import { CaptainRepository } from './features/captain/captain.repository';
import { CaptainService } from './features/captain/captain.service';
import { TeamMateRepository } from './features/teamMate/teamMate.repository';
import { TeamMateService } from './features/teamMate/teamMate.service';
import { authService } from './features/user/authentication.service';
import { CaptainController } from './features/captain/captain.controller';

export const router = express.Router();

//TEAM MATE
const teamMateRepository = new TeamMateRepository();
const teamMateService = new TeamMateService(teamMateRepository);

//CAPTAIN
const captainRepository = new CaptainRepository();
const captainService = new CaptainService(captainRepository);
const captainController = new CaptainController(captainService);

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository, captainService, teamMateService);
const userController = new UserController(userService);

router.post('/login', (req, res) => userController.checkLogin(req, res));
router.get('/captains', (req, res, next) => authService.verifyToken(req, res, next) ,(_, res) =>captainController.getAll(_, res));

