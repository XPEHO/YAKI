import { Pool, QueryResult } from "pg";
import UserModel from "./user.dtoIn";
import { UserRepository } from "./user.repository";
import * as argon2 from 'argon2';
import * as crypto from 'crypto';
import { authService } from "./authentication.service";
import { CaptainService } from "../captain/captain.service";
import { TeamMateService } from "../teamMate/teamMate.service";
import { TeamMateDtoOut } from "../teamMate/teamMate.dtoOut";
import { TeamMateDtoIn } from "../teamMate/teamMate.dtoIn";
import { CaptainDtoIn } from "../captain/captain.dtoIn";
import { CaptainDtoOut } from "../captain/captain.dtoOut";

export class UserService {

    userRepository : UserRepository;
    captainService: CaptainService;
    teamMateService: TeamMateService;

    constructor(repository : UserRepository, captainService: CaptainService, teamMateService: TeamMateService) {
        this.userRepository = repository;
        this.captainService = captainService;
        this.teamMateService = teamMateService;
    }

    /**
     * Send the login and password to the repository and return a user if its found
     * @param object 
     * @returns 
     */
    checkUserLoginDetails = async (object: any) => {
        const user = await this.userRepository.getByLogin(object.login, object.password); 
        if(await authService.checkPasswordWithHash(object.password, user.user_password)) {
            // if captain_id column is null, return a team_mate
            if(user.captain_id === null) {
                return new TeamMateDtoOut(
                    user.team_mate_id,
                    user.user_id,
                    user.team_mate_team_id,
                    user.user_last_name,
                    user.user_first_name,
                    user.user_email
                );
            } // else return a captain
            return new CaptainDtoOut(
                user.captain_id,
                user.user_id,
                user.user_last_name,
                user.user_first_name,
                user.user_email
            )
        } else {
            throw new Error('Bad authentification details');
        }
    }
}