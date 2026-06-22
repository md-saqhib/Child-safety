package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.Dbconnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteIncidentServlet")
public class DeleteIncidentServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,
        HttpServletResponse response)
        throws IOException {

    try{

        int id =
        Integer.parseInt(
        request.getParameter("id"));

        Connection con =
        Dbconnection.getConnection();

        String sql =
        "DELETE FROM incidents WHERE incident_id=?";

        PreparedStatement ps =
        con.prepareStatement(sql);

        ps.setInt(1, id);

        ps.executeUpdate();

        response.sendRedirect("ViewIncidentServlet");

    }catch(Exception e){
        e.printStackTrace();
    }
}

}
