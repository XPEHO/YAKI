import {Client} from "pg";
import {DeclarationDtoIn} from "./declaration.dtoIn";
import YakiUtils from "../../utils/yakiUtils";

export class DeclarationRepository {
  /**
   * Creates a new instance of DeclarationRepository.
   * Initializes the private field pool with a new instance of Pool using environment variables.
   */
  

  /**
   * Inserts a new declaration into the database.
   * @param declarationList The declaration to be inserted.
   * @returns A created declaration.
   */
  async createDeclaration(declarationList: DeclarationDtoIn[]) {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect()
    const valuesString: string = YakiUtils.queryValuesString(declarationList, declarationList[0], 1);
    const declarationValuesList: Array<string> = YakiUtils.objectsListToValuesList(declarationList);
    const query = `INSERT INTO declaration 
    (
      declaration_date, 
      declaration_date_start, 
      declaration_date_end, 
      declaration_team_mate_id, 
      declaration_status,
      declaration_team_id
    ) 
  VALUES ${valuesString} RETURNING *`
    try {
      const result = await client.query(query,declarationValuesList);
      const declarationToFront = [
        new DeclarationDtoIn(
          result.rows[0].declaration_id,
          result.rows[0].declaration_team_mate_id,
          result.rows[0].declaration_date,
          result.rows[0].declaration_date_start,
          result.rows[0].declaration_date_end,
          result.rows[0].declaration_status,
          result.rows[0].declaration_team_id
        ),
      ];
      client.end()
      return declarationToFront;
    } finally {
      client.end();
    }
  }

  /**
   * Inset the half day declaration into the database
   * @param declarationList declaration list containing the declaratin to be inserted
   * @returns return the inserted halfDay declarations.
   */
  async createHalfDayDeclaration(declarationList: DeclarationDtoIn[]) {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect()
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
          declaration_status,
          declaration_team_id
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
          item.declaration_status,
          item.declaration_team_id
        );
      });

      return declarationListToFront;
    } finally {
      client.end();
    }
  }

  /**
   * Get the latest declaration for a team mate
   * Select current day declaration, OR declaration ending after the current day (vacation or "other" situation)
   * @param {number} teamMateId - number
   * @returns An array of Declaration objects.
   */
  async getDeclarationForTeamMate(teamMateId: number): Promise<DeclarationDtoIn[]> {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect()
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
            declaration.declaration_status,
            declaration.declaration_team_id
          )
        );
      }

      return declarationListToFront;
    } finally {
      client.end();
    }
  }
}
