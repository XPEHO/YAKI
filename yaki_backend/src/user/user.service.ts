import { Pool, QueryResult } from "pg";
import UserModel from "./user.model";
import { UserRepository } from "./user.repository";

export class UserService {

    repository : UserRepository;

    constructor(repository : UserRepository) {
        this.repository = repository;
    }

    /**
     * Send the login and password to the repository and return a user if its found
     * @param object 
     * @returns 
     */
    checkUserLoginDetails = async (object: any) => {
        const user = await this.repository.getByUsernameAndPassword(object.login, object.password); 
        return user;
    }
}