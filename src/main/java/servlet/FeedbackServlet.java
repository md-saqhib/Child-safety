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

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {

private static final long serialVersionUID = 1L;

protected void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        HttpSession session = request.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String message =
                request.getParameter("message");

        Connection con =
                Dbconnection.getConnection();

        String sql =
                "INSERT INTO feedback(user_id,message) VALUES(?,?)";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(1, userId);
        ps.setString(2, message);

        int i = ps.executeUpdate();

        if (i > 0) {
            response.sendRedirect("feedback.jsp?msg=success");
        } else {
            response.getWriter().println("Feedback Failed");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
