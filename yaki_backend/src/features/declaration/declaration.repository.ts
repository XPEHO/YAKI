import {Client, QueryResult} from "pg";
import {DeclarationDtoIn} from "./declaration.dtoIn";
import YakiUtils from "../../utils/yakiUtils";
import {DeclarationDto} from "./declaration.dto";
import {DataError} from "../../errors/dataOrDataBaseError";

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
  async createDeclaration(declarationList: DeclarationDto[], isLatest: boolean) {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect();
    const declarationValuesList: Array<string> =
      YakiUtils.objectsListToValuesList(declarationList);
    const query = `INSERT INTO declaration 
    (
      declaration_user_id, 
      declaration_date, 
      declaration_date_start, 
      declaration_date_end, 
      declaration_status,
      declaration_team_id,
      declaration_is_latest
    ) 
    VALUES ($1, $2, $3, $4, $5, $6, ${isLatest}) RETURNING *`;

    try {
      const result = await client.query(query, declarationValuesList);
      // make sure current day declaration is correctly tagged as true
      if (isLatest === true && result.rows[0].declaration_is_latest === false) {
        throw new TypeError("Error while creating declaration");
      }
      const declarationToFront = [
        new DeclarationDtoIn(
          result.rows[0].declaration_id,
          result.rows[0].declaration_user_id,
          result.rows[0].declaration_date,
          result.rows[0].declaration_date_start,
          result.rows[0].declaration_date_end,
          result.rows[0].declaration_status,
          result.rows[0].declaration_team_id
        ),
      ];
      client.end();
      return declarationToFront;
    } finally {
      client.end();
    }
  }

  /**
   * Inset the half day declaration into the database.
   * @param declarationList declaration list containing the declaratin to be inserted
   * @returns return the inserted halfDay declarations.
   */
  async createHalfDayDeclaration(declarationList: DeclarationDto[], isLatest: boolean) {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect();
    const declarationsValuesList: Array<string> =
      YakiUtils.objectsListToValuesList(declarationList);

    try {
      const result = await client.query(
        `INSERT INTO declaration
        (
          declaration_user_id, 
          declaration_date, 
          declaration_date_start, 
          declaration_date_end, 
          declaration_status,
          declaration_team_id,
          declaration_is_latest
        )
        VALUES ($1, $2, $3, $4, $5, $6, ${isLatest}), ($7, $8, $9, $10, $11, $12, ${isLatest}) RETURNING *`,
        declarationsValuesList
      );

      // make sure both current half day declaration are correctly tagged as true
      for (let declaration of result.rows) {
        if (isLatest === true && declaration.declaration_is_latest === false) {
          throw new TypeError("Error while creating declaration");
        }
      }

      const declarationListToFront = result.rows.map((item) => {
        return new DeclarationDtoIn(
          item.declaration_id,
          item.declaration_user_id,
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
   * Select current day declaration, OR declaration ending after the current day (absence situation)
   * @param {number} userId - number
   * @returns An array of Declaration objects.
   */
  async getLatestDeclarationByUserId(userId: number): Promise<DeclarationDtoIn[]> {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect();
    try {
      // now()::date  =  YYYY-MM-dd
      const result = await client.query(
        `SELECT *
        FROM declaration
        WHERE declaration_user_id = $1
        AND declaration_date::date = now()::date
        OR (
            declaration_date_start::date <= now()::date
            AND declaration_date_end::date > now()::date 
            AND declaration_status = 'absence'
        )
        ORDER BY declaration_date DESC LIMIT 10`,
        [userId]
      );

      const declarationListToFront: DeclarationDtoIn[] = [];

      for (let declaration of result.rows) {
        declarationListToFront.push(
          new DeclarationDtoIn(
            declaration.declaration_id,
            declaration.declaration_user_id,
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

  async getDeclaredDaysByUserId(userId: number): Promise<String[]> { 
    // Todo: do it yknow    
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    client.connect();

    const sqlQueryString = 
    `
    with recursive DateElements as (
      select 
        declaration_date_start as date, 
        declaration_date_end,
        declaration_user_id
      from public.declaration
      where declaration_user_id = $1

      union all

      select 
        date + interval '1 day', 
        declaration_date_end,
        declaration_user_id
      from DateElements
      where date < declaration_date_end and declaration_user_id = $1
    )
    select distinct to_char(date, 'yyyy-mm-dd') date
    from DateElements
    order by to_char(date, 'yyyy-mm-dd');
    `

    let result: QueryResult<any>
    try {
      result = await client.query(sqlQueryString, [userId])
    } catch(error) {
      console.error(error)
      return []
    }

    let days: String[]  = []
    for (let day of result.rows) {
      days.push(day.date)
    }

    return days
  }

  async unflagLatestDeclaration(userId: number): Promise<void> {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect();

    try {
      await client.query(
        `UPDATE public.declaration d
         SET declaration_is_latest = false
         WHERE declaration_is_latest = true 
         AND declaration_user_id = $1
         AND DATE(declaration_date) = (CURRENT_DATE AT TIME ZONE 'UTC')
         RETURNING *`,
        [userId]
      );
    } catch (error: any) {
      throw new DataError("Error during unflag preview declaration: " + error.message);
    } finally {
      client.end();
    }
  }
}
