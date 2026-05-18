package Util;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBConnection {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/notes_manager",
                "root",
                "Divyani@123"   
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
