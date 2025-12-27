package com.profile.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database connection utility class for JavaDB (Derby)
 * Connects to existing student_profiles database - PORTABLE VERSION
 */
public class DatabaseUtil {
    
    // JavaDB (Derby) EMBEDDED connection - Works on any computer!
    private static final String DB_URL = "jdbc:derby:student_profiles";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";
    private static final String DB_DRIVER = "org.apache.derby.jdbc.EmbeddedDriver";
    
    // Load Derby JDBC Driver
    static {
        try {
            Class.forName(DB_DRIVER);
            System.out.println("✓ JavaDB (Derby) Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("✗ JavaDB Driver not found!");
            e.printStackTrace();
        }
    }
    
    /**
     * Get database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("✓ Database connection established to student_profiles!");
            return conn;
        } catch (SQLException e) {
            System.err.println("✗ Failed to connect to database!");
            System.err.println("Error: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Close database connection
     * @param conn Connection to close
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("✓ Database connection closed!");
            } catch (SQLException e) {
                System.err.println("✗ Error closing connection!");
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Test database connection
     */
    public static void main(String[] args) {
        System.out.println("=== Testing JavaDB Embedded Connection ===");
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("✓✓✓ DATABASE CONNECTION TEST SUCCESSFUL! ✓✓✓");
                System.out.println("Database: " + conn.getMetaData().getDatabaseProductName());
                System.out.println("URL: " + conn.getMetaData().getURL());
                closeConnection(conn);
            }
        } catch (SQLException e) {
            System.err.println("✗✗✗ DATABASE CONNECTION TEST FAILED! ✗✗✗");
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}