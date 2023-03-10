import { Pool } from 'pg';
import { DeclarationDtoIn } from './declaration.dtoIn';

export class DeclarationRepository {
  private pool: Pool;

  /**
   * Creates a new instance of DeclarationRepository.
   * Initializes the private field pool with a new instance of Pool using environment variables.
   */
  constructor() {
    this.pool = new Pool({
      user: `${process.env.DB_USER}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_PASSWORD}`,
      port: Number(process.env.DB_PORT)
    });
  }

  /**
   * Inserts a new declaration into the database.
   * @param declaration The declaration to be inserted.
   * @returns A created declaration.
   */
  async createDeclaration(declaration: DeclarationDtoIn) {
    const { declarationDate, declarationTeamMateId, declarationStatus } = declaration;
    const result = await this.pool.query(
      'INSERT INTO declaration (declaration_date, declaration_team_mate_id, declaration_status) VALUES ($1, $2, $3) RETURNING *',
      [declarationDate, declarationTeamMateId, declarationStatus]
    );
    const declarationToFront = new DeclarationDtoIn(
        result.rows[0].declaration_id,
        result.rows[0].declaration_team_mate_id,
        result.rows[0].declaration_date,
        result.rows[0].declaration_status
    )
    return declarationToFront;
  }
}