<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Dbconnection" %>
<%
Integer userId = (Integer)session.getAttribute("userId");
if(userId == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Children - Child Safety Tracking System</title>

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

        .table > thead {
            background-color: #0f172a;
            color: white;
        }

        .btn-back {
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 500;
            padding: 8px 18px;
            transition: all 0.2s;
        }

        .btn-add {
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
                            <i class="fas fa-users text-primary me-2"></i> My Children Directory
                        </h2>
                        <p class="text-muted small mb-0 mt-1">Manage and review all your registered children records inside the system database.</p>
                    </div>
                    <a href="addChild.jsp" class="btn btn-primary btn-add shadow-sm">
                        <i class="fas fa-plus-circle me-1"></i> Add Another Child
                    </a>
                </div>

                <div class="table-container bg-white mb-3">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead style="background: #0f172a; color: white;">
                                <tr>
                                    <th class="ps-4 py-3">Profile ID</th>
                                    <th class="py-3">Child Full Name</th>
                                    <th class="py-3">Age (Yrs)</th>
                                    <th class="py-3">Gender</th>
                                    <th class="pe-4 py-3">School / Institution Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                boolean recordsFound = false;
                                try {
                                    Connection con = Dbconnection.getConnection();
                                    PreparedStatement ps = con.prepareStatement("SELECT * FROM child WHERE user_id=?");
                                    ps.setInt(1, userId);
                                    ResultSet rs = ps.executeQuery();

                                    while(rs.next()){
                                        recordsFound = true;
                                %>
                                <tr>
                                    <td class="ps-4 fw-semibold text-primary">#<%= rs.getInt("child_id") %></td>
                                    <td class="fw-medium text-dark"><%= rs.getString("child_name") %></td>
                                    <td><%= rs.getInt("age") %></td>
                                    <td>
                                        <% 
                                        String g = rs.getString("gender");
                                        if("Male".equalsIgnoreCase(g)) { 
                                        %>
                                            <span class="badge bg-primary-subtle text-primary px-2.5 py-1.5"><i class="fas fa-mars me-1"></i> Male</span>
                                        <% } else if("Female".equalsIgnoreCase(g)) { %>
                                            <span class="badge bg-danger-subtle text-danger px-2.5 py-1.5"><i class="fas fa-venus me-1"></i> Female</span>
                                        <% } else { %>
                                            <span class="badge bg-secondary-subtle text-secondary px-2.5 py-1.5"><i class="fas fa-genderless me-1"></i> Other</span>
                                        <% } %>
                                    </td>
                                    <td class="pe-4 text-muted">
                                        <i class="fas fa-school text-black-50 me-1 small"></i> 
                                        <%= (rs.getString("school_name") == null || rs.getString("school_name").trim().isEmpty()) ? "Not Specified" : rs.getString("school_name") %>
                                    </td>
                                </tr>
                                <%
                                    }
                                    if(!recordsFound) {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="fas fa-user-slash fa-3x mb-3 text-black-50 d-block"></i>
                                        No children records found. Click on "Add Another Profile" above to register your child.
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