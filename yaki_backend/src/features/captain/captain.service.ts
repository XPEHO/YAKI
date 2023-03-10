import { CaptainRepository } from "./captain.repository";

export class CaptainService {
    captainRepository: CaptainRepository;

    constructor(repository: CaptainRepository) {
        this.captainRepository = repository;
    }

    /**
     * Get a captain by its user_id
     * @param user_id 
     * @returns 
     */
    getByUserId = async (user_id: string) => {
        return await this.captainRepository.getByUserId(user_id);
    }

    /**
     * Retrieve all captains from the database
     * @returns 
     */
    getAll = async () => {
        return await this.captainRepository.getAll();
    }
}