import { CaptainRepository } from "./captain.repository";

export class CaptainService {
    captainRepository: CaptainRepository;

    constructor(repository: CaptainRepository) {
        this.captainRepository = repository;
    }

    getByUserId = async (user_id: string) => {
        return await this.captainRepository.getByUserId(user_id);
    }
}