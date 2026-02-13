package com.university.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DEFAULT_URL =
            "jdbc:mysql://universityportal-db-project-0389.k.aivencloud.com:27223/defaultdb"
                    + "?useSSL=true&requireSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DEFAULT_USER = "avnadmin";
    private static final String DEFAULT_PASSWORD = "";

    private static final String URL = firstNonBlank(
            System.getenv("DB_URL"),
            System.getenv("JDBC_DATABASE_URL"),
            DEFAULT_URL
    );

    private static final String USER = firstNonBlank(
            System.getenv("DB_USER"),
            System.getenv("JDBC_DATABASE_USER"),
            DEFAULT_USER
    );

    private static final String PASSWORD = firstNonBlank(
            System.getenv("DB_PASSWORD"),
            System.getenv("JDBC_DATABASE_PASSWORD"),
            DEFAULT_PASSWORD
    );

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("MySQL JDBC Driver not found in runtime classpath.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.trim().isEmpty()) {
                return value.trim();
            }
        }
        return "";
    }
}