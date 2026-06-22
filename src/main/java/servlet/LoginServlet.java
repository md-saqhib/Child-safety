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
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
protected void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    String email =
    request.getParameter("email");

    String password =
    request.getParameter("password");

    try {

        Connection con =
        Dbconnection.getConnection();

        String sql =
        "SELECT * FROM users WHERE email=? AND password=?";

        PreparedStatement ps =
        con.prepareStatement(sql);

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs =
        ps.executeQuery();

        if(rs.next()) {

        	HttpSession session =
        	request.getSession();

        	session.setAttribute(
        	"email",
        	rs.getString("email"));

        	session.setAttribute(
        	"name",
        	rs.getString("full_name"));

        	session.setAttribute(
        	"userId",
        	rs.getInt("user_id"));

        	response.sendRedirect(
        	"userDashboard.jsp");

        }
        else {

            response.sendRedirect(
            "Login.jsp?error=invalid");
        }

    }
    catch(Exception e) {

        e.printStackTrace();

        response.sendRedirect(
        "Login.jsp?error=db");
    }
}


}
