import { TeamMateRepository } from "./teamMate.repository";
import { TeamMateWithDeclaration } from "./teamMateWithDeclaration.dtoOut";

export class TeamMateService {
    teamMateRepository: TeamMateRepository;

    constructor(repository: TeamMateRepository) {
        this.teamMateRepository = repository;
    }

    getByUserId = async (user_id: string) => {
        return await this.teamMateRepository.getByUserId(user_id);
    }

    getByTeamIdWithLastDeclaration = async (team_id: number) => {
        const getTeamMates : any[] = await this.teamMateRepository.getByTeamIdWithLastDeclaration(team_id);[]
        let result : TeamMateWithDeclaration[] = [];
        getTeamMates.forEach(element => {
            result.push(new TeamMateWithDeclaration(
                element.user_id,
                element.team_mate_id,
                element.user_last_name,
                element.user_first_name,
                element.declaration_date,
                element.declaration_status,
            ))
        });
        return result;
    }
}