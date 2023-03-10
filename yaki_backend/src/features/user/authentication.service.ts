import { Request, Response, NextFunction } from 'express';
import { CaptainDtoOut } from '../captain/captain.dtoOut';
import { TeamMateDtoOut } from '../teamMate/teamMate.dtoOut';

var jwt = require('jsonwebtoken');

class Service {
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
                user_id: user.userId,
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
     * Middleware that give authorization if the given token is valid.
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