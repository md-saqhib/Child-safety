package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import model.User;

public class UserDao {

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            Connection con = Dbconnection.getConnection();

            String sql =
            "INSERT INTO users(full_name,email,phone,password) VALUES(?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());

            int row = ps.executeUpdate();

            if(row > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}