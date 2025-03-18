package Util;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/construction_xpert";
    private static final String USER = "root";
    private static final String PASSWORD = "Root@123";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
            return connection;
        } catch (Exception e) {
            System.out.println("Problem connecting to database: " + e.getMessage());
            return null;
        }
    }
}