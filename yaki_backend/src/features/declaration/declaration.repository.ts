import { Pool } from 'pg';
import { Declaration } from './declaration.interface';
import dotenv from 'dotenv';

// dotenv.config();

// const pool = new Pool({
//     user: `${process.env.DB_USER}`,
//              host: `${process.env.DB_HOST}`,
//              database: `${process.env.DB_DATABASE}`,
//             password: `${process.env.DB_PASSWORD}`,
//             port: Number(process.env.DB_PORT)
//          }
// );

export class DeclarationRepository {
    private pool: Pool;

    constructor() {
        this.pool = new Pool({
            user: `${process.env.DB_USER}`,
            host: `${process.env.DB_HOST}`,
            database: `${process.env.DB_DATABASE}`,
            password: `${process.env.DB_PASSWORD}`,
            port: Number(process.env.DB_PORT)
          });
    }
    async createDeclaration(declaration: any) {
        const { declaration_date, declaration_team_mate_id, status } = declaration;
        const result = await this.pool.query(
          'INSERT INTO teammate_declarations (declaration_date, declaration_team_mate_id, status) VALUES ($1, $2, $3) RETURNING *',
          [declaration_date, declaration_team_mate_id, status]
        );
        return result.rows[0];
      }
    /**
     * Inserts a new declaration into the database.
     * @param declaration The declaration to be inserted.
     * @returns A created declaration.
     */
    // public async create(declaration: Declaration): Promise<Declaration> {
    //     const result = await pool.query(
    //         'INSERT INTO declaration (declaration_date, idTeammate, status) VALUES ($1, $2, $3) RETURNING id, date, idTeammate, status',
    //         [declaration.declaration_date, declaration.declaration_team_mate_id, declaration.status],
    //     );
    //     return result.rows[0];
    // }

    

    /**
     * Retrieves the latest declaration made by the teammate with the specified ID.
     * @param idTeammate The ID of the teammate whose declaration should be retrieved.
     * @returns An array of declarations made by the teammate, ordered by date in descending order.
     */
    // async findByTeammate(idTeammate: number): Promise<Declaration[]> {
    //     const result = await this.pool.query(
    //         'SELECT id, date, idTeammate, status FROM declarations WHERE idTeammate = $1 ORDER BY date DESC LIMIT 1',
    //         [idTeammate],
    //     );
    //     return result.rows;
    // }
}