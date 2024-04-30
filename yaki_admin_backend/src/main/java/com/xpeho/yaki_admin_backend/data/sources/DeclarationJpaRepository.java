package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.DeclarationModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;

public interface DeclarationJpaRepository extends JpaRepository<DeclarationModel, Integer> {

  @Query(value = """
      SELECT t.team_name,
          u.user_first_name, u.user_last_name,
          d.declaration_status,
          d.declaration_date,
          d.declaration_date_start,
          d.declaration_date_end
      FROM declaration d
      LEFT JOIN team t ON d.declaration_team_id = t.team_id
      LEFT JOIN "user" u ON d.declaration_user_id = u.user_id
      WHERE t.team_customer_id = ?3
      AND d.declaration_date_start BETWEEN ?1 AND ?2
      AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
      ORDER BY d.declaration_date DESC
      """, nativeQuery = true)
  List<Object[]> getDeclarationsListByCustomerId(LocalDate periodStart, LocalDate periodEnd, int id);

  @Query(value = """
      SELECT t.team_name,
          u.user_first_name, u.user_last_name,
          d.declaration_status,
          d.declaration_date,
          d.declaration_date_start,
          d.declaration_date_end
      FROM declaration d
      LEFT JOIN team t ON d.declaration_team_id = t.team_id
      LEFT JOIN "user" u ON d.declaration_user_id = u.user_id
      WHERE t.team_customer_id = ?3 AND t.team_id = ?4
      AND d.declaration_date_start BETWEEN ?1 AND ?2
      AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
      ORDER BY d.declaration_date DESC
      """, nativeQuery = true)
  List<Object[]> getDeclarationsListByCustomerAndTeamId(LocalDate periodStart, LocalDate periodEnd, int customerId,
      int teamId);

  @Query(value = """
      WITH
      ----------------------------------- DECLARATIONS FILTER BY CUSTOMER ID AND PERIOD
      filtered_declarations AS (
          SELECT d.*
          FROM declaration d
          JOIN team t ON d.declaration_team_id = t.team_id
          -- Filter by period
          WHERE d.declaration_date_start BETWEEN ?1 AND ?2
          -- Filter by customer id
          AND t.team_customer_id = ?3
          AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
      ),
      ---------------------------------- DECLARATIONS COUNT
      declaration_count AS (
          SELECT count(*) as declaration_count
          FROM filtered_declarations fd
          WHERE fd.declaration_status <> 'absence'
      ),
      remote_count AS (
          SELECT count(*) as remote_count
          FROM filtered_declarations fd
          WHERE fd.declaration_status = 'remote'
      ),
      onsite_count AS (
          SELECT count(*) as onsite_count
          FROM filtered_declarations fd
          WHERE fd.declaration_status = 'on site'
      )
      ----------------------------------- MAIN QUERY
      SELECT\s
          COALESCE(dc.declaration_count, 0) as declaration_count,
          COALESCE(rc.remote_count, 0) as remote_count,
          COALESCE(oc.onsite_count, 0) as onsite_count
      FROM declaration_count dc
      CROSS JOIN remote_count rc
      CROSS JOIN onsite_count oc
      """, nativeQuery = true)
  List<Object[]> getGlobalStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int customerId);

  @Query(value = """
        WITH
        ----------------------------------- USER FILTERED BY CUSTOMER ID
        filtered_users AS (
            SELECT u.*
            FROM "user" u
            JOIN teammate t ON u.user_id = t.teammate_user_id
            JOIN team tm ON t.teammate_team_id = tm.team_id
            WHERE tm.team_customer_id = ?3
        ),
        ----------------------------------- DECLARATIONS FILTER BY CUSTOMER ID AND PERIOD
        filtered_declarations AS (
          SELECT d.*
            FROM declaration d
            JOIN team t ON d.declaration_team_id = t.team_id
          -- Filter by period
            WHERE d.declaration_date_start BETWEEN ?1 AND ?2
          -- Filter by customer id
            AND t.team_customer_id = ?3
            AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
        ),
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
      """, nativeQuery = true)
  List<Object[]> getPerTeammateStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int id);

  @Query(value = """
        WITH
        ----------------------------------- USER FILTERED BY CUSTOMER ID
        filtered_users AS (
            SELECT u.*
            FROM "user" u
            JOIN teammate t ON u.user_id = t.teammate_user_id
            JOIN team tm ON t.teammate_team_id = tm.team_id
            WHERE tm.team_customer_id = ?3 AND tm.team_id = ?4
        ),
        ----------------------------------- DECLARATIONS FILTER BY CUSTOMER ID AND PERIOD
        filtered_declarations AS (
          SELECT d.*
            FROM declaration d
            JOIN team t ON d.declaration_team_id = t.team_id
          -- Filter by period
            WHERE d.declaration_date_start BETWEEN ?1 AND ?2
          -- Filter by customer id
            AND t.team_customer_id = ?3
            AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
          -- Filter by team id
            AND t.team_id = ?4
        ),
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
      """, nativeQuery = true)
  List<Object[]> getPerTeammateStatisticsByCustomerAndTeamId(LocalDate periodStart, LocalDate periodEnd, int customerId,
      int teamId);

  @Query(value = """
      WITH
      ----------------------------------- TEAM FILTERED BY CUSTOMER ID
      filtered_teams AS (
          SELECT t.*
          FROM team t
          WHERE t.team_customer_id = ?3\s
      ),
      ----------------------------------- DECLARATIONS FILTER BY CUSTOMER ID AND PERIOD
      filtered_declarations AS (
      	SELECT d.*
          FROM declaration d
          JOIN team t ON d.declaration_team_id = t.team_id
      	-- Filter by period
          WHERE d.declaration_date_start BETWEEN ?1 AND ?2
          AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
      	-- Filter by customer id
          AND t.team_customer_id = ?3
      ),
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
      )
      ----------------------------------- MAIN QUERY
      SELECT DISTINCT ft.team_id, ft.team_name,
      	COALESCE(dc.declaration_count, 0) as declaration_count,
      	COALESCE(rc.remote_count, 0) as remote_count,
      	COALESCE(oc.onsite_count, 0) as onsite_count
      FROM filtered_teams ft
      LEFT JOIN filtered_declarations fd ON ft.team_id = fd.declaration_team_id
      LEFT JOIN declaration_count dc ON ft.team_id = dc.declaration_team_id
      LEFT JOIN remote_count rc ON ft.team_id = rc.declaration_team_id
      LEFT JOIN onsite_count oc ON ft.team_id = oc.declaration_team_id
      """, nativeQuery = true)
  List<Object[]> getPerTeamStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int customerId);

  @Query(value = """
      WITH
      ----------------------------------- USER FILTERED BY CUSTOMER AND TEAM ID
      filtered_users AS (
          SELECT u.*
          FROM "user" u
          JOIN teammate t ON u.user_id = t.teammate_id
          JOIN team tm ON t.teammate_team_id = tm.team_id
          WHERE tm.team_customer_id = ?3
      ),
      ----------------------------------- DECLARATIONS FILTER BY CUSTOMER AND TEAM ID AND PERIOD
      filtered_declarations AS (
      	SELECT d.*,
      		CAST(EXTRACT(DOW FROM d.declaration_date - INTERVAL '1 day') AS INTEGER) % 7 as week_day
          FROM declaration d
          JOIN team t ON d.declaration_team_id = t.team_id
      	-- Filter by period
          WHERE d.declaration_date_start BETWEEN ?1 AND ?2
          AND (d.declaration_is_latest = true OR d.declaration_team_id IS NULL)
      	-- Filter by customer id
          AND t.team_customer_id = ?3
      ),
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
      ----------------------------------- MAIN QUERY
      SELECT\s
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
      """, nativeQuery = true)
  List<Object[]> getPerWeekDayStatisticsByCustomerId(LocalDate periodStart, LocalDate periodEnd, int customerId);
}
