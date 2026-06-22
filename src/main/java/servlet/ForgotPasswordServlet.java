package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import dao.Dbconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        
        HttpSession session = request.getSession();

        try {
            Connection con = Dbconnection.getConnection();
            String sql = "UPDATE users SET password = ? WHERE email = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                // Success message session mein store karenge taaki login page par show ho sake
                session.setAttribute("toastMessage", "Success: Password updated successfully!");
                session.setAttribute("toastType", "success");
                response.sendRedirect("Login.jsp"); 
            } else {
                session.setAttribute("toastMessage", "Error: Email vector not found!");
                session.setAttribute("toastType", "danger");
                response.sendRedirect("forgotPassword.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastMessage", "System Error: " + e.getMessage());
            session.setAttribute("toastType", "danger");
            response.sendRedirect("forgotPassword.jsp");
        }
    }
}