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

@WebServlet("/ReportIncidentServlet")
public class ReportIncidentServlet extends HttpServlet {
protected void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        HttpSession session =
        request.getSession();

        int userId =
        (Integer)session.getAttribute("userId");

        int childId =
        Integer.parseInt(
        request.getParameter("childId"));

        String title =
        request.getParameter("title");

        String description =
        request.getParameter("description");

        String location =
        request.getParameter("location");

        String incidentType =
        request.getParameter("incidentType");

        Connection con =
        Dbconnection.getConnection();

        PreparedStatement check =
        con.prepareStatement(

        "SELECT * FROM child " +
        "WHERE child_id=? AND user_id=?"

        );

        check.setInt(1, childId);
        check.setInt(2, userId);

        ResultSet rs =
        check.executeQuery();

        if(!rs.next())
        {
            response.getWriter().println(
            "Invalid Child Selection");
            return;
        }

        String sql =
        "INSERT INTO incidents(child_id,title,description,location,incident_type,user_id) VALUES(?,?,?,?,?,?)";

        PreparedStatement ps =
        con.prepareStatement(sql);

        ps.setInt(1, childId);
        ps.setString(2, title);
        ps.setString(3, description);
        ps.setString(4, location);
        ps.setString(5, incidentType);
        ps.setInt(6, userId);

        int i =
        ps.executeUpdate();

        if(i > 0)
        {
            response.sendRedirect(
            "userDashboard.jsp");
        }
        else
        {
            response.getWriter().println(
            "Failed");
        }

    } catch(Exception e) {

        e.printStackTrace();

        response.getWriter().println(
        "Error : " + e.getMessage());
    }
}

}
