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

@WebServlet("/UpdateIncidentServlet")
public class UpdateIncidentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int incidentId = Integer.parseInt(request.getParameter("incidentId"));
            String status = request.getParameter("status");

            Connection con = Dbconnection.getConnection();
            String sql = "UPDATE incidents SET status=? WHERE incident_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, incidentId);

            int i = ps.executeUpdate();

            // FIXED: Blank page par jaane ke bajay yeh seedhe aapko wapas live table par bhej dega
            if (i > 0) {
                response.sendRedirect("ViewIncidentServlet");
            } else {
                response.getWriter().println("<script>alert('Incident Not Found!'); window.location='ViewIncidentServlet';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().println("Error: " + e.getMessage());
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }
}