<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Dbconnection" %>
<%
Integer userId = (Integer)session.getAttribute("userId");
if(userId == null){
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Incidents - Child Safety Tracking System</title>

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

        .directory-card {
            border: none;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            background: white;
            overflow: hidden;
        }

        .table-container {
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }

        .badge {
            padding: 7px 12px;
            border-radius: 8px;
            font-weight: 500;
        }

        .btn-back {
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 500;
            padding: 8px 18px;
            transition: all 0.2s;
        }

        .btn-report {
            border-radius: 12px;
            padding: 10px 20px;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark shadow-sm">
        <div class="container">
            <span class="navbar-brand fw-bold d-flex align-items-center">
                <i class="fas fa-shield-halved text-warning me-2"></i> Child Safety Tracking System
            </span>
            <a href="userDashboard.jsp" class="btn btn-outline-light btn-sm btn-back">
                <i class="fas fa-arrow-left me-1"></i> Dashboard
            </a>
        </div>
    </nav>

    <div class="container my-5">
        <div class="card directory-card p-4">
            <div class="card-body">

                <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center mb-4 gap-3">
                    <div>
                        <h2 class="fw-bold m-0 text-dark">
                            <i class="fas fa-folder-open text-danger me-2"></i> My Incident History
                        </h2>
                        <p class="text-muted small mb-0 mt-1">Review, audit, and trace your broadcasted alerts and resolution state matrices.</p>
                    </div>
                    <a href="reportIncident.jsp" class="btn btn-danger btn-report shadow-sm">
                        <i class="fas fa-bullhorn me-1"></i> Report New Incident
                    </a>
                </div>

                <div class="table-container bg-white">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead style="background: #0f172a; color: white;">
                                <tr>
                                    <th class="ps-4 py-3">Incident ID</th>
                                    <th class="py-3">Child Name</th>
                                    <th class="py-3">Title / Core Problem</th>
                                    <th class="py-3">Incident Location</th>
                                    <th class="py-3">Category Type</th>
                                    <th class="py-3">Resolution Status</th>
                                    <th class="pe-4 py-3">Timestamp Logged</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                boolean found = false;
                                try {
                                    Connection con = Dbconnection.getConnection();
                                    String sql = "SELECT i.*, c.child_name FROM incidents i " +
                                                 "JOIN child c ON i.child_id=c.child_id " +
                                                 "WHERE c.user_id=? ORDER BY i.incident_id DESC";
                                                 
                                    PreparedStatement ps = con.prepareStatement(sql);
                                    ps.setInt(1, userId);
                                    ResultSet rs = ps.executeQuery();

                                    while(rs.next()){
                                        found = true;
                                %>
                                <tr>
                                    <td class="ps-4 fw-semibold text-danger">#<%= rs.getInt("incident_id") %></td>
                                    <td class="fw-medium text-dark"><%= rs.getString("child_name") %></td>
                                    <td class="fw-medium"><%= rs.getString("title") %></td>
                                    <td><i class="fas fa-location-dot text-muted me-1 small"></i> <%= rs.getString("location") %></td>
                                    <td>
                                        <span class="badge bg-light text-dark border"><%= rs.getString("incident_type") %></span>
                                    </td>
                                    <td>
                                        <%
                                        String status = rs.getString("status");
                                        if("Resolved".equalsIgnoreCase(status)){
                                        %>
                                        <span class="badge bg-success-subtle text-success border border-success-subtle">Resolved</span>
                                        <% } else { %>
                                        <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle">Pending</span>
                                        <% } %>
                                    </td>
                                    <td class="pe-4 text-muted small"><%= rs.getTimestamp("created_at") %></td>
                                </tr>
                                <%
                                    }
                                    if(!found){
                                %>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="fas fa-inbox fa-3x mb-3 text-black-50 d-block"></i>
                                        No active safety incidents reported from your master profile yet.
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
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>