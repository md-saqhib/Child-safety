package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.Dbconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ViewIncidentServlet")
public class ViewIncidentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Connection con = Dbconnection.getConnection();
            int totalIncidents = 0;

            PreparedStatement psCount = con.prepareStatement("SELECT COUNT(*) FROM incidents");
            ResultSet countRs = psCount.executeQuery();

            if (countRs.next()) {
                totalIncidents = countRs.getInt(1);
            }

            String sql = "SELECT * FROM incidents ORDER BY incident_id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            out.println("<html>");
            out.println("<head>");
            out.println("<title>Incident Management - Admin Panel</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>");
            out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css'>");
            out.println("<link href='https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap' rel='stylesheet'>");
            
            // Layout Framework CSS
            out.println("<style>");
            out.println("body { background: #f1f5f9; font-family: 'Poppins', sans-serif; color: #1e293b; }");
            out.println(".sidebar { height: 100vh; background: #0f172a; padding-top: 25px; position: fixed; width: 240px; box-shadow: 4px 0 15px rgba(0, 0, 0, 0.05); z-index: 100; }");
            out.println(".sidebar h3 { font-size: 1.2rem; font-weight: 700; letter-spacing: 0.5px; }");
            out.println(".sidebar a { display: flex; align-items: center; padding: 14px 24px; color: #94a3b8; text-decoration: none; font-size: 0.95rem; font-weight: 500; transition: all 0.3s ease; }");
            out.println(".sidebar a i { width: 25px; font-size: 1.1rem; }");
            out.println(".sidebar a:hover, .sidebar a.active { background: #1e293b; color: #38bdf8; border-left: 4px solid #38bdf8; }");
            out.println(".main-content { margin-left: 240px; padding: 40px; }");
            out.println(".directory-card { border: none; border-radius: 20px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02); background: white; overflow: hidden; }");
            out.println(".table-container { border-radius: 16px; overflow: hidden; border: 1px solid #e2e8f0; }");
            out.println("</style>");
            out.println("</head>");
            
            out.println("<body>");

            // Sidebar Integration
            out.println("<div class='sidebar'>");
            out.println("<h3 class='text-center text-white mb-4'><i class='fas fa-shield-halved text-warning me-2'></i>Admin Center</h3>");
            out.println("<div class='px-3'><hr class='text-secondary opacity-25 m-0 mb-3'></div>");
            out.println("<a href='adminDashboard.jsp'><i class='fas fa-chart-line'></i> Dashboard</a>");
            out.println("<a href='viewUsers.jsp'><i class='fas fa-users'></i> Users Grid</a>");
            out.println("<a href='viewChildren.jsp'><i class='fas fa-child'></i> Children Vault</a>");
            out.println("<a href='ViewIncidentServlet' class='active'><i class='fas fa-triangle-exclamation'></i> Incidents Log</a>");
            out.println("<a href='viewFeedback.jsp'><i class='fas fa-comments'></i> User Reviews</a>");
            out.println("<a href='LogoutServlet' class='mt-4 text-danger'><i class='fas fa-right-from-bracket'></i> Clear Session</a>");
            out.println("</div>");

            // Main Canvas
            out.println("<div class='main-content'>");
            out.println("<div class='card directory-card p-4'>");
            out.println("<div class='card-body'>");

            // Section Branding Header
            out.println("<div class='mb-4'>");
            out.println("<h2 class='fw-bold m-0 text-dark'><i class='fas fa-triangle-exclamation text-danger me-2'></i> Incident Management Terminal</h2>");
            out.println("<p class='text-muted small mb-0 mt-1'>Review threat alerts, filter reported cases, and process lifecycle status parameters.</p>");
            out.println("</div>");

            // Statistics Alert Component
            out.println("<div class='alert alert-sm bg-danger-subtle text-danger border-0 mb-4 d-inline-flex align-items-center' style='border-radius: 10px; padding: 10px 20px;'>");
            out.println("<i class='fas fa-database me-2'></i> <span><strong>Total Operational Incidents Mapped: </strong> " + totalIncidents + "</span>");
            out.println("</div>");

            // Live Engine Filter Input
            out.println("<div class='mb-3'><div class='input-group' style='max-width: 350px;'>");
            out.println("<span class='input-group-text bg-white border-end-0 text-muted'><i class='fas fa-magnifying-glass small'></i></span>");
            out.println("<input type='text' id='searchInput' class='form-control border-start-0 ps-0' placeholder='Search live tracking grid...' style='border-radius: 0 12px 12px 0; font-size: 0.9rem;'>");
            out.println("</div></div>");

            // Table Architecture
            out.println("<div class='table-container bg-white mb-4'>");
            out.println("<div class='table-responsive'>");
            out.println("<table id='incidentTable' class='table table-hover align-middle mb-0'>");
            
            out.println("<thead style='background: #0f172a; color: white;'>");
            out.println("<tr>");
            out.println("<th class='ps-4 py-3'>Ticket ID</th>");
            out.println("<th class='py-3'>Child Reference Key</th>");
            out.println("<th class='py-3'>Title Header</th>");
            out.println("<th class='py-3'>Incident Location</th>");
            out.println("<th class='py-3'>Threat Classification</th>");
            out.println("<th class='py-3'>Current Status</th>");
            out.println("<th class='py-3 text-center'>Triage Resolution</th>");
            out.println("<th class='pe-4 py-3 text-end'>Administrative Action</th>");
            out.println("</tr>");
            out.println("</thead>");
            
            out.println("<tbody>");

            while (rs.next()) {
                int id = rs.getInt("incident_id");
                String status = rs.getString("status");

                out.println("<tr>");
                out.println("<td class='ps-4 fw-semibold text-danger'>#" + id + "</td>");
                out.println("<td class='fw-medium text-secondary'>Child: ID-" + rs.getInt("child_id") + "</td>");
                out.println("<td class='fw-medium text-dark'>" + rs.getString("title") + "</td>");
                out.println("<td class='text-muted'><i class='fas fa-location-dot me-1 small'></i> " + rs.getString("location") + "</td>");
                out.println("<td><span class='badge bg-light text-dark border px-2.5 py-1.5' style='font-size:0.8rem;'>" + rs.getString("incident_type") + "</span></td>");

                // Badge Status Mapping
                if ("Resolved".equalsIgnoreCase(status)) {
                    out.println("<td><span class='badge bg-success-subtle text-success px-2.5 py-1.5' style='border-radius:8px;'><i class='fas fa-circle-check me-1'></i> Resolved</span></td>");
                    out.println("<td class='text-center'><button class='btn btn-success btn-sm px-3 disabled' style='border-radius:8px;'><i class='fas fa-lock me-1'></i> Processed</button></td>");
                } else if ("In Progress".equalsIgnoreCase(status)) {
                    out.println("<td><span class='badge bg-warning-subtle text-warning px-2.5 py-1.5' style='border-radius:8px;'><i class='fas fa-spinner fa-spin me-1'></i> In Progress</span></td>");
                    // FIXED: Changed updateIncidentStatus.jsp to updateIncident.jsp to match your file structure
                    out.println("<td class='text-center'><a class='btn btn-warning btn-sm text-dark px-3 fw-medium' href='updateIncident.jsp?incidentId=" + id + "' style='border-radius:8px;'><i class='fas fa-arrow-up-right-from-square me-1'></i> Update</a></td>");
                } else {
                    out.println("<td><span class='badge bg-danger-subtle text-danger px-2.5 py-1.5' style='border-radius:8px;'><i class='fas fa-circle-exclamation me-1'></i> Pending</span></td>");
                    // FIXED: Changed updateIncidentStatus.jsp to updateIncident.jsp to match your file structure
                    out.println("<td class='text-center'><a class='btn btn-primary btn-sm px-3' href='updateIncident.jsp?incidentId=" + id + "' style='border-radius:8px;'><i class='fas fa-wrench me-1'></i> Resolve</a></td>");
                }

                // Delete Action Context
                out.println("<td class='pe-4 text-end'>");
                out.println("<a class='btn btn-outline-danger btn-sm border-0' href='DeleteIncidentServlet?id=" + id + "' style='border-radius:8px;' onclick='return confirm(\"Are you sure you want to purge this record?\")'>");
                out.println("<i class='fas fa-trash'></i> Purge");
                out.println("</a>");
                out.println("</td>");

                out.println("</tr>");
            }

            out.println("</tbody>");
            out.println("</table>");
            out.println("</div>");
            out.println("</div>");

            out.println("<a href='adminDashboard.jsp' class='btn btn-outline-dark px-4 py-2' style='border-radius:10px; font-size:0.9rem; font-weight:500;'><i class='fas fa-arrow-left me-1'></i> Return to Terminal</a>");

            out.println("</div>"); // card-body
            out.println("</div>"); // card
            out.println("</div>"); // main-content

            // Filter Engine Search Implementation Script
            out.println("<script>");
            out.println("document.getElementById('searchInput').addEventListener('keyup', function(){");
            out.println("var filter=this.value.toLowerCase();");
            out.println("var rows=document.querySelectorAll('#incidentTable tbody tr');");
            out.println("rows.forEach(function(row){");
            out.println("var text=row.innerText.toLowerCase();");
            out.println("row.style.display=text.includes(filter)?'':'none';");
            out.println("});");
            out.println("});");
            out.println("</script>");

            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='container mt-5'><div class='alert alert-danger'><h3>Compilation/Query Fault:</h3><p>" + e.getMessage() + "</p></div></div>");
        }
    }
}