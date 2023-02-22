import * as argon2 from 'argon2';
import * as crypto from 'crypto';

class Service {
    /**
     * Config details for hash algorithm 
     */
    __hashingConfig = { // based on OWASP cheat sheet recommendations (as of March, 2022)
        parallelism: 1,
        memoryCost: 64000, // 64 mb
        timeCost: 5 // number of itetations
    }

    /**
     * Hash password with a salt
     * @param password 
     * @returns 
     */
    hashPassword = async(password: string) => {
        let salt = crypto.randomBytes(16);
        return await argon2.hash(password, {
            ...this.__hashingConfig,
            salt,
        })
    }

    /**
     * Check if a hashed password match with a hashed password
     * @param password 
     * @param hash 
     * @returns 
     */
    checkPasswordWithHash = async(password: string, hash: string) => {
        console.log('hash: ' + hash + ', password: ' + password);
        return await argon2.verify(hash, password, this.__hashingConfig);
    }
}

export const authService = Object.freeze(new Service());