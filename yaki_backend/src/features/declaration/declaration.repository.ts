import {Pool} from "pg";
import {DeclarationDtoIn} from "./declaration.dtoIn";
import YakiUtils from "../../utils/yakiUtils";

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
      port: Number(process.env.DB_PORT),
    });
  }

  /**
   * Inserts a new declaration into the database.
   * @param declarationList The declaration to be inserted.
   * @returns A created declaration.
   */
  async createDeclaration(declarationList: DeclarationDtoIn[]) {
    const client = await this.pool.connect();
    const valuesString: string = YakiUtils.queryValuesString(declarationList, declarationList[0], 1);
    const declarationValuesList: Array<string> = YakiUtils.objectsListToValuesList(declarationList);

    try {
      const result = await client.query(
        `INSERT INTO declaration 
          (
            declaration_date, 
            declaration_date_start, 
            declaration_date_end, 
            declaration_team_mate_id, 
            declaration_status
          ) 
        VALUES ${valuesString} RETURNING *`,
        declarationValuesList
      );
      const declarationToFront = [
        new DeclarationDtoIn(
          result.rows[0].declaration_id,
          result.rows[0].declaration_team_mate_id,
          result.rows[0].declaration_date,
          result.rows[0].declaration_date_start,
          result.rows[0].declaration_date_end,
          result.rows[0].declaration_status
        ),
      ];
      return declarationToFront;
    } finally {
      client.release();
    }
  }

  /**
   * Inset the half day declaration into the database
   * @param declarationList declaration list containing the declaratin to be inserted
   * @returns return the inserted halfDay declarations.
   */
  async createHalfDayDeclaration(declarationList: DeclarationDtoIn[]) {
    const client = await this.pool.connect();

    const valuesString: string = YakiUtils.queryValuesString(declarationList, declarationList[0], 1);
    const declarationsValuesList: Array<string> = YakiUtils.objectsListToValuesList(declarationList);

    try {
      const result = await client.query(
        `INSERT INTO declaration
        (
          declaration_date, 
          declaration_date_start, 
          declaration_date_end, 
          declaration_team_mate_id, 
          declaration_status
        )
        VALUES ${valuesString} RETURNING *`,
        declarationsValuesList
      );

      const declarationListToFront = result.rows.map((item) => {
        return new DeclarationDtoIn(
          item.declaration_id,
          item.declaration_team_mate_id,
          item.declaration_date,
          item.declaration_date_start,
          item.declaration_date_end,
          item.declaration_status
        );
      });

      return declarationListToFront;
    } finally {
      client.release();
    }
  }

  /**
   * Get the latest declaration for a team mate
   * Select current day declaration, OR declaration ending after the current day (vacation or "other" situation)
   * @param {number} teamMateId - number
   * @returns An array of Declaration objects.
   */
  async getDeclarationForTeamMate(teamMateId: number): Promise<DeclarationDtoIn[]> {
    const client = await this.pool.connect();
    try {
      // now()::date  =  YYYY-MM-dd
      const result = await client.query(
        `SELECT *
        FROM declaration
        WHERE declaration_team_mate_id = $1
        AND declaration_date::date = now()::date
        OR (
            declaration_date_start::date <= now()::date
            AND declaration_date_end::date > now()::date 
            AND (
              declaration_status = 'vacation' 
              OR
              declaration_status = 'other'
              )
            )
        ORDER BY declaration_date DESC LIMIT 10`,
        [teamMateId]
      );

      const declarationListToFront: DeclarationDtoIn[] = [];

      for (let declaration of result.rows) {
        declarationListToFront.push(
          new DeclarationDtoIn(
            declaration.declaration_id,
            declaration.declaration_team_mate_id,
            declaration.declaration_date,
            declaration.declaration_date_start,
            declaration.declaration_date_end,
            declaration.declaration_status
          )
        );
      }

      return declarationListToFront;
    } finally {
      client.release();
    }
  }

  /**
   * "This function updates the declaration_date, declaration_team_mate_id, and declaration_status of a
   * declaration in the database, given the declaration_id of the declaration to be updated."
   * @param {number} declarationId - number,
   * @param {Declaration} declaration - Declaration
   */
  async updateDeclarationStatus(declarationId: number, declaration: DeclarationDtoIn[]): Promise<void> {
    const {declarationDate, declarationDateStart, declarationDateEnd, declarationTeamMateId, declarationStatus} =
      declaration[0];
    const client = await this.pool.connect();
    try {
      await client.query(
        `UPDATE declaration 
        SET declaration_date = $1, 
        declaration_date_start = $2, 
        declaration_date_end = $3, 
        declaration_team_mate_id = $4, 
        declaration_status = $5 
        WHERE declaration_id = $6`,
        [
          declarationDate,
          declarationDateStart,
          declarationDateEnd,
          declarationTeamMateId,
          declarationStatus,
          declarationId,
        ]
      );
    } finally {
      client.release();
    }
  }

  /**
   * This function returns a promise that resolves to a declaration object, or null if no declaration
   * is found.
   * @param {number} declarationId - number
   * @returns The result of the query.
   */
  async getDeclarationById(declarationId: number): Promise<DeclarationDtoIn> {
    const client = await this.pool.connect();
    try {
      const result = await client.query(
        `SELECT *
        FROM declaration
        WHERE declaration_id = $1
        `,
        [declarationId]
      );
      return result.rows[0];
    } finally {
      client.release();
    }
  }
}
