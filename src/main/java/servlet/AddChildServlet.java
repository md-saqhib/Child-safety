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

@WebServlet("/AddChildServlet")
public class AddChildServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

        	HttpSession session =
        			request.getSession();

        			int userId =
        			(Integer)session.getAttribute("userId");

            String childName =
            request.getParameter("childName");

            int age =
            Integer.parseInt(request.getParameter("age"));

            String gender =
            request.getParameter("gender");

            String schoolName =
            request.getParameter("schoolName");

            String address =
            request.getParameter("address");

            Connection con =
            Dbconnection.getConnection();

            String sql =
            "INSERT INTO child(user_id,child_name,age,gender,school_name,address) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, childName);
            ps.setInt(3, age);
            ps.setString(4, gender);
            ps.setString(5, schoolName);
            ps.setString(6, address);

            int i = ps.executeUpdate();

            if(i > 0)
            	response.sendRedirect(
            			"userDashboard.jsp");
            else
                response.getWriter().println("Failed");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}