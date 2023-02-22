import express from 'express'
import { UserController } from './features/user/user.controller'
import { UserService } from './features/user/user.service'
import { UserRepository } from './features/user/user.repository'
import { CaptainRepository } from './features/captain/captain.repository';
import { CaptainService } from './features/captain/captain.service';
import { TeamMateRepository } from './features/teamMate/teamMate.repository';
import { TeamMateService } from './features/teamMate/teamMate.service';

export const router = express.Router();

//TEAM MATE
const teamMateRepository = new TeamMateRepository();
const teamMateService = new TeamMateService(teamMateRepository);

//CAPTAIN
const captainRepository = new CaptainRepository();
const captainService = new CaptainService(captainRepository);

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository, captainService, teamMateService);
const userController = new UserController(userService);

router.post('/login', userController.checkLogin)
