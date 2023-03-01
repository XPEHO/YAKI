import { TeamMateRepository } from "./teamMate.repository";

export class TeamMateService {
    teamMateRepository: TeamMateRepository;

    constructor(repository: TeamMateRepository) {
        this.teamMateRepository = repository;
    }

    getByUserId = async (user_id: string) => {
        return await this.teamMateRepository.getByUserId(user_id);
    }
}