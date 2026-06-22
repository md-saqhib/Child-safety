package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.Dbconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {


protected void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    String fullName =
    request.getParameter("fullName");

    String email =
    request.getParameter("email");

    String phone =
    request.getParameter("phone");

    String password =
    request.getParameter("password");

    try {

        Connection con =
        Dbconnection.getConnection();

        PreparedStatement check =
        con.prepareStatement(
        "SELECT * FROM users WHERE email=?");

        check.setString(1, email);

        ResultSet rs =
        check.executeQuery();

        if(rs.next()) {

            response.getWriter().println(
            "<h2>Email Already Registered!</h2>" +
            "<br>" +
            "<a href='register.jsp'>Go Back</a>"
            );

            return;
        }

        String sql =
        "INSERT INTO users(full_name,email,phone,password) VALUES(?,?,?,?)";

        PreparedStatement ps =
        con.prepareStatement(sql);

        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, password);

        int i =
        ps.executeUpdate();

        if(i > 0) {

            response.sendRedirect(
            "Login.jsp?msg=registered");

        } else {

            response.getWriter().println(
            "<h2>Registration Failed</h2>"
            );
        }

    }
    catch(Exception e) {

        e.printStackTrace();

        response.getWriter().println(
        "<h2>Error : "
        + e.getMessage()
        + "</h2>"
        );
    }
}


}
