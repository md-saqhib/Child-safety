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

@WebServlet("/ResolveIncidentServlet")
public class ResolveIncidentServlet extends HttpServlet {


protected void doGet(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        int id =
        Integer.parseInt(
        request.getParameter("id"));

        Connection con =
        Dbconnection.getConnection();

        PreparedStatement ps =
        con.prepareStatement(
        "UPDATE incidents SET status='Resolved' WHERE incident_id=?");

        ps.setInt(1, id);

        ps.executeUpdate();

        response.sendRedirect("ViewIncidentServlet");

    } catch(Exception e) {

        e.printStackTrace();
    }
}


}
