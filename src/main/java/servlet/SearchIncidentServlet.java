package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.Dbconnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchIncidentServlet")
public class SearchIncidentServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,
        HttpServletResponse response)
        throws IOException {

    response.setContentType("text/html");

    PrintWriter out =
            response.getWriter();

    try {

        String childName =
                request.getParameter("childName");

        Connection con =
                Dbconnection.getConnection();

        String sql =
        "SELECT i.*, c.child_name " +
        "FROM incidents i " +
        "JOIN child c ON i.child_id = c.child_id " +
        "WHERE c.child_name LIKE ?";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setString(1,
                "%" + childName + "%");

        ResultSet rs =
                ps.executeQuery();

        out.println("<html>");
        out.println("<head>");

        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>");

        out.println("</head>");

        out.println("<body class='bg-light'>");

        out.println("<div class='container mt-5'>");

        out.println("<h2 class='mb-4'>Search Results</h2>");

        out.println("<table class='table table-bordered table-hover'>");

        out.println("<tr class='table-dark'>");
        out.println("<th>ID</th>");
        out.println("<th>Child Name</th>");
        out.println("<th>Title</th>");
        out.println("<th>Location</th>");
        out.println("<th>Type</th>");
        out.println("<th>Status</th>");
        out.println("</tr>");

        boolean found = false;

        while(rs.next()) {

            found = true;

            out.println("<tr>");

            out.println("<td>"
                    + rs.getInt("incident_id")
                    + "</td>");

            out.println("<td>"
                    + rs.getString("child_name")
                    + "</td>");

            out.println("<td>"
                    + rs.getString("title")
                    + "</td>");

            out.println("<td>"
                    + rs.getString("location")
                    + "</td>");

            out.println("<td>"
                    + rs.getString("incident_type")
                    + "</td>");

            out.println("<td>"
                    + rs.getString("status")
                    + "</td>");

            out.println("</tr>");
        }

        if(!found) {

            out.println("</table>");

            out.println("<div class='alert alert-danger'>");
            out.println("No incidents found.");
            out.println("</div>");

        } else {

            out.println("</table>");
        }

        out.println("<a href='searchIncident.jsp' class='btn btn-primary'>Search Again</a>");

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");

    } catch(Exception e) {

        e.printStackTrace();
    }
}


}
