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
            const captain : CaptainDtoIn = await this.captainService.getByUserId(user.user_id);
            // if there is no captain with the specified user_id, check for a team_mate
            if(captain === undefined) {
                const teamMate : TeamMateDtoIn = await this.teamMateService.getByUserId(user.user_id);
                return new TeamMateDtoOut(
                    teamMate.team_mate_id,
                    teamMate.user_id,
                    teamMate.team_mate_team_id,
                    teamMate.user_last_name,
                    teamMate.user_first_name,
                    teamMate.user_email
                );
            }
            return new CaptainDtoOut(
                captain.captain_id,
                captain.user_id,
                captain.user_last_name,
                captain.user_first_name,
                captain.user_email
            )
        } else {
            throw new Error('Bad authentification details');
        }
    }
}