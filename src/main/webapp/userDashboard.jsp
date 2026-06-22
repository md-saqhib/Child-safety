<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Dbconnection" %>
<%
String email = (String)session.getAttribute("email");
if(email == null) {
    response.sendRedirect("Login.jsp");
    return;
}
int userId = (Integer)session.getAttribute("userId");
String name = (String)session.getAttribute("name");

int total = 0;
int pending = 0;
int resolved = 0;

try {
    Connection con = Dbconnection.getConnection();
    
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT COUNT(*) FROM incidents i JOIN child c ON i.child_id=c.child_id WHERE c.user_id=?"
    );
    ps1.setInt(1, userId);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()) total = rs1.getInt(1);

    PreparedStatement ps2 = con.prepareStatement(
        "SELECT COUNT(*) FROM incidents i JOIN child c ON i.child_id=c.child_id WHERE c.user_id=? AND i.status='Pending'"
    );
    ps2.setInt(1, userId);
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()) pending = rs2.getInt(1);

    PreparedStatement ps3 = con.prepareStatement(
        "SELECT COUNT(*) FROM incidents i JOIN child c ON i.child_id=c.child_id WHERE c.user_id=? AND i.status='Resolved'"
    );
    ps3.setInt(1, userId);
    ResultSet rs3 = ps3.executeQuery();
    if(rs3.next()) resolved = rs3.getInt(1);
    
} catch(Exception e) {
    e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Child Safety System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            background: #f1f5f9;
            font-family: 'Poppins', sans-serif;
            color: #1e293b;
        }

        .navbar {
            background: #0f172a !important;
            padding: 15px 0;
        }

        .welcome-card {
            background: linear-gradient(135deg, #1e40af, #3b82f6);
            color: white;
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(30, 64, 175, 0.15);
        }

        /* Metrics Display Counter Cards */
        .dashboard-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
            color: white;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        .bg-gradient-total { background: linear-gradient(135deg, #4f46e5, #6366f1); }
        .bg-gradient-pending { background: linear-gradient(135deg, #ea580c, #f97316); }
        .bg-gradient-resolved { background: linear-gradient(135deg, #16a34a, #22c55e); }

        /* Quick Action Click Modules */
        .action-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.04);
            background: white;
            transition: all 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.1);
        }

        .action-card .btn {
            border-radius: 10px;
            padding: 8px 25px;
            font-weight: 500;
        }

        /* Bottom Directory Utilities */
        .utility-btn {
            border-radius: 14px;
            padding: 15px;
            font-weight: 500;
            transition: all 0.2s;
            border: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        
        .utility-btn:hover {
            transform: scale(1.02);
            filter: brightness(0.95);
        }

        /* Data Tables Styling */
        .table-container {
            border-radius: 16px;
            overflow: hidden;
            border: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .table > thead {
            background-color: #1e293b;
            color: white;
        }

        .badge {
            padding: 7px 12px;
            border-radius: 8px;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <div class="container">
            <span class="navbar-brand fw-bold d-flex align-items-center">
                <i class="fas fa-shield-halved text-warning me-2"></i> Child Safety Tracking System
            </span>
            <div class="ms-auto">
                <span class="text-light me-3 d-none d-sm-inline-block"><i class="far fa-user-circle me-1"></i> Parent Portal</span>
                <a href="LogoutServlet" class="btn btn-outline-light btn-sm px-3 rounded-pill">Logout <i class="fas fa-sign-out-alt ms-1"></i></a>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        
        <div class="card welcome-card p-4 mb-5">
            <div class="card-body">
                <h2 class="fw-bold mb-1">Welcome, <%= name %> 👋</h2>
                <p class="mb-0 text-white-50">Stay updated regarding tracked profiles, register instances, and systematically monitor ongoing investigations.</p>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card dashboard-card bg-gradient-total p-3">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <h6 class="text-white-50 uppercase fw-bold small mb-1">TOTAL INCIDENTS</h6>
                            <h1 class="display-5 fw-bold m-0"><%= total %></h1>
                        </div>
                        <i class="fas fa-list fa-3x opacity-25"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card dashboard-card bg-gradient-pending p-3">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <h6 class="text-white-50 uppercase fw-bold small mb-1">PENDING RESOLUTIONS</h6>
                            <h1 class="display-5 fw-bold m-0"><%= pending %></h1>
                        </div>
                        <i class="fas fa-clock fa-3x opacity-25"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card dashboard-card bg-gradient-resolved p-3">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <h6 class="text-white-50 uppercase fw-bold small mb-1">RESOLVED ISSUES</h6>
                            <h1 class="display-5 fw-bold m-0"><%= resolved %></h1>
                        </div>
                        <i class="fas fa-check-circle fa-3x opacity-25"></i>
                    </div>
                </div>
            </div>
        </div>

        <h4 class="fw-bold mb-4 text-dark">Quick Submissions & Tracking</h4>
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card action-card p-3 text-center">
                    <div class="card-body">
                        <div class="p-3 bg-light rounded-circle d-inline-block mb-3">
                            <i class="fas fa-child fa-2x text-primary"></i>
                        </div>
                        <h5 class="fw-bold">Add Child</h5>
                        <p class="text-muted small mb-4">Register new children safely onto the records structure.</p>
                        <a href="addChild.jsp" class="btn btn-primary w-100">Open Panel</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card action-card p-3 text-center">
                    <div class="card-body">
                        <div class="p-3 bg-light rounded-circle d-inline-block mb-3">
                            <i class="fas fa-triangle-exclamation fa-2x text-danger"></i>
                        </div>
                        <h5 class="fw-bold">Report Incident</h5>
                        <p class="text-muted small mb-4">Instantly report a dynamic hazard or incident details securely.</p>
                        <a href="reportIncident.jsp" class="btn btn-danger w-100">Open Forms</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card action-card p-3 text-center">
                    <div class="card-body">
                        <div class="p-3 bg-light rounded-circle d-inline-block mb-3">
                            <i class="fas fa-comments fa-2x text-warning"></i>
                        </div>
                        <h5 class="fw-bold">Feedback</h5>
                        <p class="text-muted small mb-4">Send feedback logs or submit direct support queries.</p>
                        <a href="feedback.jsp" class="btn btn-warning text-dark w-100">Open Module</a>
                    </div>
                </div>
            </div>
        </div>

        <h4 class="fw-bold mb-4 text-dark">Quick Directory Filters</h4>
        <div class="row g-3 mb-5">
            <div class="col-md-4">
                <a href="myChildren.jsp" class="btn btn-info utility-btn text-white w-100 p-3 bg-opacity-75">
                    <i class="fas fa-users me-2"></i> My Children Directory
                </a>
            </div>
            <div class="col-md-4">
                <a href="myIncident.jsp" class="btn btn-secondary utility-btn w-100 p-3 text-white" style="background-color: #64748b;">
                    <i class="fas fa-folder-open me-2"></i> My Inchident
                </a>
            </div>
            <div class="col-md-4">
                <a href="searchIncident.jsp" class="btn btn-dark utility-btn w-100 p-3">
                    <i class="fas fa-magnifying-glass me-2"></i> Search Incident
                </a>
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold m-0 text-dark">Recent Activity Logs</h4>
            <span class="badge bg-white text-secondary shadow-sm">Showing last 5 events</span>
        </div>

        <div class="card table-container bg-white">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead style="background: #0f172a; color: white;">
                        <tr>
                            <th class="ps-4 py-3">Incident ID</th>
                            <th class="py-3">Title Description</th>
                            <th class="py-3">Incident Location</th>
                            <th class="py-3">Resolution Status</th>
                            <th class="pe-4 py-3">Timestamp Logged</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        boolean dynamicHasContent = false;
                        try {
                            Connection con = Dbconnection.getConnection();
                            PreparedStatement recentPs = con.prepareStatement(
                                "SELECT i.* FROM incidents i JOIN child c ON i.child_id=c.child_id WHERE c.user_id=? ORDER BY i.incident_id DESC LIMIT 5"
                            );
                            recentPs.setInt(1, userId);
                            ResultSet recent = recentPs.executeQuery();
                            
                            while(recent.next()) {
                                dynamicHasContent = true;
                        %>
                        <tr>
                            <td class="ps-4 fw-semibold text-primary">#<%= recent.getInt("incident_id") %></td>
                            <td class="fw-medium"><%= recent.getString("title") %></td>
                            <td><i class="fas fa-location-dot text-muted me-1 small"></i> <%= recent.getString("location") %></td>
                            <td>
                                <%
                                String status = recent.getString("status");
                                if(status.equalsIgnoreCase("Resolved")){
                                %>
                                <span class="badge bg-success-subtle text-success border border-success-subtle">Resolved</span>
                                <% } else { %>
                                <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle">Pending</span>
                                <% } %>
                            </td>
                            <td class="pe-4 text-muted small"><%= recent.getTimestamp("created_at") %></td>
                        </tr>
                        <%
                            }
                            if(!dynamicHasContent) {
                        %>
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="fas fa-folder-inbox fa-3x mb-3 text-black-50 d-block"></i>
                                No recent safety incidents reported under your monitored profiles.
                            </td>
                        </tr>
                        <%
                            }
                        } catch(Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>