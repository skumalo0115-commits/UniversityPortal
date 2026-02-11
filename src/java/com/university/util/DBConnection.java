package com.university.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/university_portal?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "123456";

    private static String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.trim().isEmpty()) {
                return value.trim();
            }
        }
        return null;
    }

    private static String resolveUrl() {
        String configured = firstNonBlank(
                System.getenv("DB_URL"),
                System.getenv("MYSQL_URL"),
                System.getenv("JDBC_DATABASE_URL")
        );

        if (configured != null) {
            return configured;
        }

        String host = firstNonBlank(System.getenv("MYSQLHOST"));
        String port = firstNonBlank(System.getenv("MYSQLPORT"));
        String database = firstNonBlank(System.getenv("MYSQLDATABASE"), System.getenv("DB_NAME"));

        if (host != null && database != null) {
            if (port == null) {
                port = "3306";
            }
            return "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        }

        return DEFAULT_URL;
    }

    private static String resolveUser() {
        return firstNonBlank(
                System.getenv("DB_USER"),
                System.getenv("MYSQLUSER"),
                System.getenv("JDBC_DATABASE_USERNAME"),
                DEFAULT_USER
        );
    }

    private static String resolvePassword() {
        return firstNonBlank(
                System.getenv("DB_PASSWORD"),
                System.getenv("MYSQLPASSWORD"),
                System.getenv("JDBC_DATABASE_PASSWORD"),
                DEFAULT_PASSWORD
        );
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(resolveUrl(), resolveUser(), resolvePassword());
    }
}
