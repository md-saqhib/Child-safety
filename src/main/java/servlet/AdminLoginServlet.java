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

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException, ServletException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection con = Dbconnection.getConnection()) {

            String sql = "SELECT * FROM admin WHERE username=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // ✅ Create session
                HttpSession session = request.getSession();
                session.setAttribute("admin", username);

                session.setMaxInactiveInterval(30 * 60);

             
                response.sendRedirect("adminDashboard.jsp");
            }
            else {
               
                response.sendRedirect("adminLogin.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();

            response.sendRedirect("adminLogin.jsp?error=server");
        }
    }
}