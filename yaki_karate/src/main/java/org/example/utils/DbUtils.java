package org.example.utils;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import io.github.cdimascio.dotenv.Dotenv;

public class DbUtils {

    private final JdbcTemplate jdbc;
    public DbUtils() {
        Dotenv dotenv = Dotenv.load();
        String driver = "org.postgresql.Driver";
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(driver);
        dataSource.setUrl(dotenv.get("DB_URL"));
        dataSource.setUsername(dotenv.get("DB_USER"));
        dataSource.setPassword(dotenv.get("DB_PASSWORD"));
        jdbc = new JdbcTemplate(dataSource);
    }

    public Object readValue(String query) {
        return jdbc.queryForObject(query, Object.class);
    }
    /*public String readValue(String query) {
        return url + " " + username + " " + password;
    }*/
    public Map<String, Object> readRow(String query) {
        return jdbc.queryForMap(query);
    }

    public List<Map<String, Object>> readRows(String query) {
        return jdbc.queryForList(query);
    }

}
