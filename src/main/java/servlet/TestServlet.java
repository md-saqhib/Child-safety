package servlet;

	import java.io.IOException;
	import java.sql.Connection;

	import dao.Dbconnection;
	import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.HttpServlet;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpServletResponse;

	@WebServlet("/TestServlet")
	public class TestServlet extends HttpServlet {

	    protected void doGet(HttpServletRequest request,
	                         HttpServletResponse response)
	            throws ServletException, IOException {

	    	Connection con = Dbconnection.getConnection();

	    	if(con == null) {
	    	    response.getWriter().println("Connection Object = null");
	    	}
	    }
	}


