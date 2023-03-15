import express from "express";
import {UserController} from "./features/user/user.controller";
import {UserService} from "./features/user/user.service";
import {UserRepository} from "./features/user/user.repository";
import {CaptainRepository} from "./features/captain/captain.repository";
import {CaptainService} from "./features/captain/captain.service";
import {TeamMateRepository} from "./features/teamMate/teamMate.repository";
import {TeamMateService} from "./features/teamMate/teamMate.service";
import {authService} from "./features/user/authentication.service";
import {CaptainController} from "./features/captain/captain.controller";
import {Pool, QueryResult} from "pg";

export const router = express.Router();

//TEAM MATE
const teamMateRepository = new TeamMateRepository();
const teamMateService = new TeamMateService(teamMateRepository);

//CAPTAIN
const captainRepository = new CaptainRepository();
const captainService = new CaptainService(captainRepository);
const captainController = new CaptainController(captainService);

//USER
const userRepository = new UserRepository();
const userService = new UserService(userRepository, captainService, teamMateService);
const userController = new UserController(userService);

router.post("/login", (req, res) => userController.checkLogin(req, res));
router.get(
  "/captains",
  (req, res, next) => authService.verifyToken(req, res, next),
  (_, res) => captainController.getAll(_, res)
);

router.get("/teamMates", async (_, res) => {
  const pool = new Pool({
    user: `${process.env.DB_ROLE}`,
    host: `${process.env.DB_HOST}`,
    database: `${process.env.DB_DATABASE}`,
    password: `${process.env.DB_ROLE_PWD}`,
    port: Number(process.env.DB_PORT),
  });
  const poolResult: QueryResult = await pool.query(
    `
            SELECT *
            FROM public.user
            INNER JOIN public.team_mate ON user_id = team_mate_user_id
            INNER JOIN (
                SELECT
                    MAX(declaration_date) AS declaration_date,
                    declaration_team_mate_id
                FROM public.declaration
                GROUP BY declaration_team_mate_id
            ) AS max_decl
            ON team_mate.team_mate_id = max_decl.declaration_team_mate_id
            INNER JOIN public.declaration
            ON max_decl.declaration_date = declaration.declaration_date
            AND max_decl.declaration_team_mate_id = declaration.declaration_team_mate_id;
            `
  );
  console.log(poolResult.rows);
  await pool.end();
  // If the user was found in the database
  res.send(poolResult.rows);
});
