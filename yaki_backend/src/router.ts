import express from 'express'
import { UserController } from './user/user.controller'
import { UserService } from './user/user.service'
import { UserRepository } from './user/user.repository'

export const router = express.Router();

const userRepository = new UserRepository();
const userService = new UserService(userRepository);
const userController = new UserController(userService);

router.post('/login', userController.checkLogin)