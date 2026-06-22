<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Dbconnection" %>
<%
String admin = (String)session.getAttribute("admin");
if(admin == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Feedback - Admin Panel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            background: #f1f5f9;
            font-family: 'Poppins', sans-serif;
            color: #1e293b;
        }

        /* Fixed Master Sidebar Navigation */
        .sidebar {
            height: 100vh;
            background: #0f172a;
            padding-top: 25px;
            position: fixed;
            width: 240px;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.05);
            z-index: 100;
        }

        .sidebar h3 {
            font-size: 1.2rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 14px 24px;
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sidebar a i {
            width: 25px;
            font-size: 1.1rem;
        }

        .sidebar a:hover, .sidebar a.active {
            background: #1e293b;
            color: #38bdf8;
            border-left: 4px solid #38bdf8;
        }

        /* Core Canvas Workspace Setup */
        .main-content {
            margin-left: 240px;
            padding: 40px;
        }

        .directory-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02);
            background: white;
            overflow: hidden;
        }

        .table-container {
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h3 class="text-center text-white mb-4">
            <i class="fas fa-shield-halved text-warning me-2"></i>Admin Center
        </h3>
        <div class="px-3"><hr class="text-secondary opacity-25 m-0 mb-3"></div>
        
        <a href="adminDashboard.jsp"><i class="fas fa-chart-line"></i> Dashboard</a>
        <a href="viewUsers.jsp"><i class="fas fa-users"></i> Users Grid</a>
        <a href="viewChildren.jsp"><i class="fas fa-child"></i> Children Vault</a>
        <a href="ViewIncidentServlet"><i class="fas fa-triangle-exclamation"></i> Incidents Log</a>
        <a href="viewFeedback.jsp" class="active"><i class="fas fa-comments"></i> User Reviews</a>
        <a href="LogoutServlet" class="mt-4 text-danger"><i class="fas fa-right-from-bracket"></i> Clear Session</a>
    </div>

    <div class="main-content">
        <div class="card directory-card p-4">
            <div class="card-body">
                
                <div class="mb-4">
                    <h2 class="fw-bold m-0 text-dark">
                        <i class="fas fa-comments text-warning me-2"></i> User Feedback Directory
                    </h2>
                    <p class="text-muted small mb-0 mt-1">Review user submissions, system optimization logs, and platform reviews.</p>
                </div>

                <div class="table-container bg-white mb-4">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead style="background: #0f172a; color: white;">
                                <tr>
                                    <th class="ps-4 py-3">Feedback ID</th>
                                    <th class="py-3">Sender (User ID)</th>
                                    <th class="py-3" style="width: 50%;">Message Content</th>
                                    <th class="pe-4 py-3">Timestamp Logged</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                boolean feedbackExists = false;
                                try {
                                    Connection con = Dbconnection.getConnection();
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery("SELECT * FROM feedback ORDER BY feedback_id DESC");

                                    while(rs.next()){
                                        feedbackExists = true;
                                %>
                                <tr>
                                    <td class="ps-4 fw-semibold text-warning">#<%= rs.getInt("feedback_id") %></td>
                                    <td class="fw-medium text-secondary"><i class="fas fa-user-circle me-1 text-black-50"></i> User ID: <%= rs.getInt("user_id") %></td>
                                    <td class="text-dark fw-medium" style="word-break: break-word;"><%= rs.getString("message") %></td>
                                    <td class="pe-4 text-muted small">
                                        <i class="far fa-clock me-1 small"></i> <%= rs.getTimestamp("created_at") %>
                                    </td>
                                </tr>
                                <%
                                    }
                                    if(!feedbackExists) {
                                %>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        <i class="fas fa-comment-slash fa-3x mb-3 text-black-50 d-block"></i>
                                        No reviews or user feedbacks logged inside the system telemetry yet.
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

                <a href="adminDashboard.jsp" class="btn btn-outline-dark px-4 py-2" style="border-radius: 10px; font-size: 0.9rem; font-weight: 500;">
                    <i class="fas fa-arrow-left me-1"></i> Return to Terminal
                </a>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>