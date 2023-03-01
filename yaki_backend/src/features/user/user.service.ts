import { UserRepository } from "./user.repository";
import { authService } from "./authentication.service";
import { CaptainService } from "../captain/captain.service";
import { TeamMateService } from "../teamMate/teamMate.service";
import { TeamMateDtoOut } from "../teamMate/teamMate.dtoOut";
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
        const searchUser = await this.userRepository.getByLogin(object.login); 
        if(await authService.checkPasswords(object.password, searchUser.user_password)) {
            let user = undefined;
            // if captain_id column is null, create a team_mate
            if(searchUser.captain_id === null) {
                user = new TeamMateDtoOut(
                    searchUser.team_mate_id,
                    searchUser.user_id,
                    searchUser.team_mate_team_id,
                    searchUser.user_last_name,
                    searchUser.user_first_name,
                    searchUser.user_email
                );
            } else {  // else create a captain
                user = new CaptainDtoOut(
                    searchUser.captain_id,
                    searchUser.user_id,
                    searchUser.user_last_name,
                    searchUser.user_first_name,
                    searchUser.user_email
                )
            }
            // add a token to the user before sending to front
            return authService.createToken(user);
        } else {
            throw new Error('Bad authentification details');
        }
    }
}
