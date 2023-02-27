import * as argon2 from 'argon2';
import * as crypto from 'crypto';
import { Request, Response, NextFunction } from 'express';
import { CaptainDtoOut } from '../captain/captain.dtoOut';
import { TeamMateDtoOut } from '../teamMate/teamMate.dtoOut';

var jwt = require('jsonwebtoken');

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
     * Check if the password send by the client match the one from the database
     * @param password 
     * @param hash 
     * @returns 
     */
    checkPasswords = async(passwordDb: string, passwordClient: string) => {
        if(passwordDb === passwordClient) {
            return true
        } 
        return false
    }

    /**
     * Method to create an authorization token
     * @param user 
     * @returns 
     */
    createToken = async(user: CaptainDtoOut | TeamMateDtoOut) => {
        const token = jwt.sign(
            {
                user_id: user.user_id,
                user_email: user.email
            },
            process.env.TOKEN_SECRET,
            {
                // set expire time to 5 minutes for development purpose
                expiresIn: 300,
            }
        );
        user.token = token;
        return user;
    }

    /**
     * Middleware that give authorization if the given token is valid
     * @param req 
     * @param res 
     * @param next 
     * @returns 
     */
    verifyToken = async(req: Request, res: Response, next: NextFunction) => {
        const token = req.headers["x-access-token"];

        if(!token) {
            return res.status(403).send("A token is required for authentification")
        }
        try {
            const decoded = jwt.verify(token, process.env.TOKEN_SECRET);
            req.body.user = decoded;
        } catch (err) {
            return res.status(401).send("Invalid Token");
        }
        return next();
    }
}

export const authService = Object.freeze(new Service());