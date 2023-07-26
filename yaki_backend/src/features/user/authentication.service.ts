import {Request, Response, NextFunction} from "express";
import {CaptainDtoOut} from "../captain/captain.dtoOut";
import {TeammateDtoOut} from "../teammate/teammate.dtoOut";
import bcrypt from "bcrypt";

const jwt = require("jsonwebtoken");

class Service {
  /**
   * use Bcrypt scync to compare planeText password with the hashed password version saved in database
   * @param password coming from login
   * @param hashedpw hash password coming from database
   * @returns boolean
   */
  comparePw = (password: string, hashedpw: string) => {
    return bcrypt.compareSync(password, hashedpw);
  };

  /**
   * Method to create an authorization token
   * @param user
   * @returns
   */
  createToken = async (user: CaptainDtoOut | TeammateDtoOut) => {
    const token = jwt.sign(
      {
        user_id: user.userId,
        user_email: user.email,
      },
      // added backtick cause jest didn't want to read it otherwise
      `${process.env.TOKEN_SECRET}`,
      {
        expiresIn: "30d",
      }
    );
    user.token = token;
    return user;
  };

  /**
   * Middleware that give authorization if the given token is valid.
   * @param req
   * @param res
   * @param next
   * @returns
   */
  verifyToken = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.headers["x-access-token"];

    if (!token) {
      return res.status(403).send("A token is required for authentification");
    }
    try {
      const decoded = jwt.verify(token, process.env.TOKEN_SECRET);
      if (req.headers["user_id"] != decoded.user_id) {
        throw new Error();
      }
    } catch (err) {
      return res.status(401).send("Invalid Token");
    }
    return next();
  };
}

export const authService = Object.freeze(new Service());
