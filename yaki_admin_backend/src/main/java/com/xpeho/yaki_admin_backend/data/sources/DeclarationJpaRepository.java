package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.DeclarationModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;

public interface DeclarationJpaRepository extends JpaRepository<DeclarationModel, Integer> {

  // --------------------------------------------GLOBAL CTE-----------------------------------------------
  String CTE_FILTERED_USERS_START = """
    ----------------------------------- USER FILTERED
    -- We want users :
    -- that are linked to a team of the current customer
    -- OR that have a declaration linked to a team of to the current customer in the period selected
    filtered_users AS (
      SELECT distinct u.*
      FROM "user" u
      JOIN declaration d ON u.user_id = d.declaration_user_id
      JOIN teammate tm ON u.user_id = tm.teammate_user_id
      JOIN team t ON
        (tm.teammate_team_id = t.team_id)
        OR (d.declaration_team_id = t.team_id AND d.declaration_date BETWEEN ?1 AND ?2)
  """;

  String CTE_FILTERED_USERS_CONDITION_BY_CUSTOMER = """
    WHERE t.team_customer_id = ?3
  """;

  String CTE_FILTERED_USERS_CONDITION_BY_CUSTOMER_AND_TEAM = """
    WHERE t.team_customer_id = ?3 AND t.team_id = ?4
  """;

  String CTE_FILTERED_USERS_END = """
      )
  """;

  String CTE_FILTERED_USERS_BY_CUSTOMER = CTE_FILTERED_USERS_START + CTE_FILTERED_USERS_CONDITION_BY_CUSTOMER + CTE_FILTERED_USERS_END;
  String CTE_FILTERED_USERS_BY_CUSTOMER_AND_TEAM = CTE_FILTERED_USERS_START + CTE_FILTERED_USERS_CONDITION_BY_CUSTOMER_AND_TEAM + CTE_FILTERED_USERS_END;


  String CTE_FILTERED_DECLARATIONS_START = """
    ----------------------------------- DECLARATIONS FILTERED
    -- We want declarations in the period selected :
    -- that are linked to a team of the current customer AND are the last of the day
    -- OR that are not linked to any team AND are linked to a user currently in a team of the customer (This condition is carried by the final JOIN)
    filtered_declarations AS (
      SELECT d.*
      FROM declaration d
      LEFT JOIN team t ON d.declaration_team_id = t.team_id
      WHERE d.declaration_date BETWEEN ?1 AND ?2
        AND (
          (
  """;

  String CTE_FILTERED_DECLARATIONS_CONDITION_BY_CUSTOMER = """    
    t.team_customer_id = ?3
  """;

  String CTE_FILTERED_DECLARATIONS_CONDITION_BY_CUSTOMER_AND_TEAM = """    
    t.team_customer_id = ?3 AND t.team_id = ?4
  """;

  String CTE_FILTERED_DECLARATIONS_END = """ 
        AND d.declaration_is_latest = true)
        OR
        (d.declaration_team_id IS NULL)
      )
    )
  """;

  String CTE_FILTERED_DECLARATIONS_BY_CUSTOMER = CTE_FILTERED_DECLARATIONS_START + CTE_FILTERED_DECLARATIONS_CONDITION_BY_CUSTOMER + CTE_FILTERED_DECLARATIONS_END;
  String CTE_FILTERED_DECLARATIONS_BY_CUSTOMER_AND_TEAM = CTE_FILTERED_DECLARATIONS_START + CTE_FILTERED_DECLARATIONS_CONDITION_BY_CUSTOMER_AND_TEAM + CTE_FILTERED_DECLARATIONS_END;


  String CTE_CUSTOM_DECLARATIONS = """
    ----------------------------------- CUSTOM DECLARATIONS
    -- We create a new list of declarations using our filters to make counts
    custom_declarations AS (
      SELECT\s
          COALESCE(t.team_name, 'Absence') as team_name, t.team_id,
          fu.user_first_name, fu.user_last_name, fu.user_id,
          fd.declaration_status,
          fd.declaration_date,
          fd.declaration_date_start,
          fd.declaration_date_end
      FROM filtered_declarations fd
      LEFT JOIN team t ON fd.declaration_team_id = t.team_id
      LEFT JOIN filtered_users fu ON fd.declaration_user_id = fu.user_id
      ORDER BY fd.declaration_date DESC
    )
  """;



  // --------------------------------------------DECLARATIONS LIST-----------------------------------------------
  String DECLARATIONS_LIST_MAIN_QUERY = """
    ----------------------------------- MAIN QUERY
    SELECT cd.team_name, cd.user_first_name, cd.user_last_name, cd.declaration_status, cd.declaration_date,
      cd.declaration_date_start, cd.declaration_date_end
    FROM custom_declarations cd
  """;


  @Query(value = """
        WITH
      """
      + CTE_FILTERED_USERS_BY_CUSTOMER
      + """
          ,
        """
      + CTE_FILTERED_DECLARATIONS_BY_CUSTOMER
      + """
          ,
        """
      + CTE_CUSTOM_DECLARATIONS
      + DECLARATIONS_LIST_MAIN_QUERY, nativeQuery = true)
  List<Object[]> getDeclarationsListByCustomerId(LocalDate periodStart, LocalDate periodEnd, int customerId);

  @Query(value = """
        WITH
      """
      + CTE_FILTERED_USERS_BY_CUSTOMER_AND_TEAM
      + """
          ,
        """
      + CTE_FILTERED_DECLARATIONS_BY_CUSTOMER_AND_TEAM
      + """
          ,
        """
      + CTE_CUSTOM_DECLARATIONS
      + DECLARATIONS_LIST_MAIN_QUERY, nativeQuery = true)
  List<Object[]> getDeclarationsListByCustomerAndTeamId(LocalDate periodStart, LocalDate periodEnd, int customerId, int teamId);



  // --------------------------------------------GLOBAL STATISTICS-----------------------------------------------
  String GLOBAL_COUNTS = """
    ---------------------------------- DECLARATIONS COUNT
    declaration_count AS (
        SELECT count(*) as declaration_count
        FROM custom_declarations cd
    ),
    remote_count AS (
        SELECT count(*) as remote_count
        FROM custom_declarations cd
        WHERE cd.declaration_status = 'remote'
    ),
    onsite_count AS (
        SELECT count(*) as onsite_count
        FROM custom_declarations cd
        WHERE cd.declaration_status = 'on site'
    ),
    absence_count AS (
        SELECT count(*) as absence_count
        FROM custom_declarations cd
        WHERE cd.declaration_status = 'absence'
    )
  """;

  String GLOBAL_MAIN_QUERY = """
    ----------------------------------- MAIN QUERY
    SELECT
        COALESCE(dc.declaration_count, 0) as declaration_count,
        COALESCE(rc.remote_count, 0) as remote_count,
        COALESCE(oc.onsite_count, 0) as onsite_count,
        COALESCE(ac.absence_count, 0) as absence_count
    FROM declaration_count dc
    CROSS JOIN remote_count rc
    CROSS JOIN onsite_count oc
    CROSS JOIN absence_count ac
  """;


  @Query(value = """
        WITH
      """
      + CTE_FILTERED_USERS_BY_CUSTOMER
      + """
          ,
        """
      + CTE_FILTERED_DECLARATIONS_BY_CUSTOMER
      + """
          ,
        """
      + CTE_CUSTOM_DECLARATIONS
      + """
          ,
        """
      + GLOBAL_COUNTS
      + GLOBAL_MAIN_QUERY, nativeQuery = true)
  List<Object[]> getGlobalStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int customerId);



  // --------------------------------------------PER TEAMMATES-----------------------------------------------
  String PER_TEAMMATE_COUNTS = """
    ---------------------------------- DECLARATIONS COUNT
    declaration_count AS (
       SELECT fd.declaration_user_id, count(*) as declaration_count
       FROM filtered_declarations fd
       GROUP BY fd.declaration_user_id
    ),
    remote_count AS (
       SELECT fd.declaration_user_id, count(*) as remote_count
       FROM filtered_declarations fd
       WHERE fd.declaration_status = 'remote'
       GROUP BY fd.declaration_user_id
    ),
    onsite_count AS (
       SELECT fd.declaration_user_id, count(*) as onsite_count
       FROM filtered_declarations fd
       WHERE fd.declaration_status = 'on site'
       GROUP BY fd.declaration_user_id
    ),
    absence_count AS (
       SELECT fd.declaration_user_id, count(*) as absence_count
       FROM filtered_declarations fd
       WHERE fd.declaration_status = 'absence'
       GROUP BY fd.declaration_user_id
    )
    """;

  String PER_TEAMMATE_MAIN_QUERY = """
    ----------------------------------- MAIN QUERY
    SELECT DISTINCT fu.user_id, fu.user_first_name, fu.user_last_name,
       COALESCE(dc.declaration_count, 0) as declaration_count,
       COALESCE(rc.remote_count, 0) as remote_count,
       COALESCE(oc.onsite_count, 0) as onsite_count,
       COALESCE(vc.absence_count, 0) as absence_count
    FROM filtered_users fu
    LEFT JOIN filtered_declarations fd ON fu.user_id = fd.declaration_user_id
    LEFT JOIN declaration_count dc ON fu.user_id = dc.declaration_user_id
    LEFT JOIN remote_count rc ON fu.user_id = rc.declaration_user_id
    LEFT JOIN onsite_count oc ON fu.user_id = oc.declaration_user_id
    LEFT JOIN absence_count vc ON fu.user_id = vc.declaration_user_id
  """;


  @Query(value = """
        WITH
      """
      + CTE_FILTERED_USERS_BY_CUSTOMER
      + """
          ,
        """
      + CTE_FILTERED_DECLARATIONS_BY_CUSTOMER
      + """
          ,
        """
      + PER_TEAMMATE_COUNTS
      + PER_TEAMMATE_MAIN_QUERY, nativeQuery = true)
  List<Object[]> getPerTeammateStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int id);

  @Query(value = """
        WITH
      """
      + CTE_FILTERED_USERS_BY_CUSTOMER_AND_TEAM
      + """
          ,
        """
      + CTE_FILTERED_DECLARATIONS_BY_CUSTOMER_AND_TEAM
      + """
          ,
        """
      + PER_TEAMMATE_COUNTS
      + PER_TEAMMATE_MAIN_QUERY, nativeQuery = true)
  List<Object[]> getPerTeammateStatisticsByCustomerAndTeamId(LocalDate periodStart, LocalDate periodEnd, int customerId,
      int teamId);



  // --------------------------------------------PER TEAM-----------------------------------------------
  String CTE_FILTERED_TEAMS = """
    ----------------------------------- TEAM FILTERED
    -- We want teams of the current customer
    filtered_teams AS (
      SELECT t.*
      FROM team t
      WHERE t.team_customer_id = ?3
    )
  """;

  String PER_TEAM_COUNTS = """
    ---------------------------------- DECLARATIONS COUNT
    declaration_count AS (
      SELECT fd.declaration_team_id, count(*) as declaration_count
      FROM filtered_declarations fd
      GROUP BY fd.declaration_team_id
    ),
    remote_count AS (
      SELECT fd.declaration_team_id, count(*) as remote_count
      FROM filtered_declarations fd
      WHERE fd.declaration_status = 'remote'
      GROUP BY fd.declaration_team_id
    ),
    onsite_count AS (
      SELECT fd.declaration_team_id, count(*) as onsite_count
      FROM filtered_declarations fd
      WHERE fd.declaration_status = 'on site'
      GROUP BY fd.declaration_team_id
    ),
    absence_count AS (
      SELECT fd.declaration_team_id, count(*) as absence_count
      FROM filtered_declarations fd
      WHERE fd.declaration_status = 'absence'
      GROUP BY fd.declaration_team_id
    )
  """;

  String PER_TEAM_MAIN_QUERY = """
    ----------------------------------- MAIN QUERY
    SELECT DISTINCT ft.team_id, ft.team_name,
      COALESCE(dc.declaration_count, 0) as declaration_count,
      COALESCE(rc.remote_count, 0) as remote_count,
      COALESCE(oc.onsite_count, 0) as onsite_count,
      COALESCE(ac.absence_count, 0) as absence_count
    FROM filtered_teams ft
    LEFT JOIN filtered_declarations fd ON ft.team_id = fd.declaration_team_id
    LEFT JOIN declaration_count dc ON ft.team_id = dc.declaration_team_id
    LEFT JOIN remote_count rc ON ft.team_id = rc.declaration_team_id
    LEFT JOIN onsite_count oc ON ft.team_id = oc.declaration_team_id
    LEFT JOIN absence_count ac ON ft.team_id = ac.declaration_team_id
  """;


  @Query(value = """
        WITH
      """
      + CTE_FILTERED_TEAMS
      + """
        ,
      """
      + CTE_FILTERED_DECLARATIONS_BY_CUSTOMER
      + """
        ,
      """
      + PER_TEAM_COUNTS
      + PER_TEAM_MAIN_QUERY, nativeQuery = true)
  List<Object[]> getPerTeamStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int customerId);



  // --------------------------------------------PER WEEK DAY-----------------------------------------------
  String CTE_FILTERED_DECLARATIONS_BY_CUSTOMER_ADDING_WEEKDAY = """
    ----------------------------------- DECLARATIONS FILTER BY CUSTOMER AND TEAM ID AND PERIOD
    filtered_declarations AS (
      SELECT d.*,
        CAST(EXTRACT(DOW FROM d.declaration_date - INTERVAL '1 day') AS INTEGER) % 7 as week_day
      FROM declaration d
      JOIN team t ON d.declaration_team_id = t.team_id
      WHERE d.declaration_date BETWEEN ?1 AND ?2
      AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
      AND t.team_customer_id = ?3
    )
  """;

  String PER_WEEKDAY_COUNTS = """
    ---------------------------------- DECLARATIONS COUNT
    declaration_count AS (
      SELECT fd.week_day, count(*) as declaration_count
      FROM filtered_declarations fd
      GROUP BY fd.week_day
    ),
    remote_count AS (
      SELECT fd.week_day, count(*) as remote_count
      FROM filtered_declarations fd
      WHERE fd.declaration_status = 'remote'
      GROUP BY fd.week_day
    ),
    onsite_count AS (
      SELECT fd.week_day, count(*) as onsite_count
      FROM filtered_declarations fd
      WHERE fd.declaration_status = 'on site'
      GROUP BY fd.week_day
    ),
    absence_count AS (
      SELECT fd.week_day, count(*) as absence_count
      FROM filtered_declarations fd
      WHERE fd.declaration_status = 'absence'
      GROUP BY fd.week_day
    )
  """;

  String PER_WEEKDAY_MAIN_QUERY = """
    ----------------------------------- MAIN QUERY
    SELECT
      CASE dc.week_day
          WHEN 0 THEN 'Monday'
          WHEN 1 THEN 'Tuesday'
          WHEN 2 THEN 'Wednesday'
          WHEN 3 THEN 'Thursday'
          WHEN 4 THEN 'Friday'
          WHEN 5 THEN 'Saturday'
          WHEN 6 THEN 'Sunday'
      END as week_day,
      COALESCE(dc.declaration_count, 0) as declaration_count,
      COALESCE(rc.remote_count, 0) as remote_count,
      COALESCE(oc.onsite_count, 0) as onsite_count,
      COALESCE(vc.absence_count, 0) as absence_count
    FROM declaration_count dc
    LEFT JOIN remote_count rc ON dc.week_day = rc.week_day
    LEFT JOIN onsite_count oc ON dc.week_day = oc.week_day
    LEFT JOIN absence_count vc ON dc.week_day = vc.week_day
    ORDER BY dc.week_day
  """;


  @Query(value = """
        WITH
      """
      + CTE_FILTERED_USERS_BY_CUSTOMER
      + """
        ,
      """
      + CTE_FILTERED_DECLARATIONS_BY_CUSTOMER_ADDING_WEEKDAY
      + """
        ,
      """
      + PER_WEEKDAY_COUNTS
      + PER_WEEKDAY_MAIN_QUERY, nativeQuery = true)
  List<Object[]> getPerWeekDayStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int customerId);

  @Query(value = """
      ---------------------------------- LATEST ACTIVITY IN A TEAM
    SELECT declaration_team_id, MAX(declaration_date)
    FROM declaration
    WHERE declaration_team_id = ?1
    GROUP BY declaration_team_id""", nativeQuery = true)
  List<Object[]> getLastTeamActivityById(Integer targetId);

  @Query(value = """
      ---------------------------------- LATEST ACTIVITY IN A TEAM
    SELECT team.team_id, MAX(declaration_date) 
    FROM declaration
    INNER JOIN team ON declaration.declaration_team_id = team.team_id
    WHERE team.team_customer_id = ?1
    GROUP BY team.team_id""", nativeQuery = true)
  List<Object[]> getLastTeamsActivityByCustomerId(Integer targetId);
}