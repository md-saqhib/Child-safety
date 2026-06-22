package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.Dbconnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ForgotAdminPasswordServlet")
public class ForgotAdminPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");

        try (Connection con = Dbconnection.getConnection()) {

            String sql = "UPDATE admin SET password=? WHERE username=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, username);

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect("adminLogin.jsp?msg=resetSuccess");
            } else {
                response.sendRedirect("forgotAdminPassword.jsp?error=invalidUser");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("forgotAdminPassword.jsp?error=server");
        }
    }
}