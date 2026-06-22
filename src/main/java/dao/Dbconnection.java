package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class Dbconnection {

    private static Connection con;

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USER");
            String dbPass = System.getenv("DB_PASS");

            if (dbUrl == null || dbUrl.isEmpty()) {
                dbUrl = "jdbc:mysql://localhost:3306/childsafetys";
                dbUser = "root";
                dbPass = "mskhan@952863";
            }

            con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            System.out.println("Connected Successfully to " + dbUrl);

        } catch (Exception e) {

            System.out.println("ERROR OCCURRED");
            e.printStackTrace();

        }

        return con;
    }
}