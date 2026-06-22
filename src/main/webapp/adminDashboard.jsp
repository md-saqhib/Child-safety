<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Dbconnection" %>
<%
String admin = (String)session.getAttribute("admin");
if(admin == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}

int users = 0;
int children = 0;
int incidents = 0;
int feedback = 0;

try {
    Connection con = Dbconnection.getConnection();
    Statement st = con.createStatement();
    
    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM users");
    if(rs1.next()) users = rs1.getInt(1);

    ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM child");
    if(rs2.next()) children = rs2.getInt(1);

    ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM incidents");
    if(rs3.next()) incidents = rs3.getInt(1);

    ResultSet rs4 = st.executeQuery("SELECT COUNT(*) FROM feedback");
    if(rs4.next()) feedback = rs4.getInt(1);
} catch(Exception e) {
    e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Child Safety Tracking System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            background: #f1f5f9;
            font-family: 'Poppins', sans-serif;
            color: #1e293b;
        }

        /* Fixed Sidebar Navigation */
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

        /* Core Workspace Setup */
        .main-content {
            margin-left: 240px;
            padding: 40px;
        }

        .welcome-card {
            background: white;
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(15, 23, 42, 0.03);
        }

        .dashboard-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02);
            background: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.05);
        }

        .card-header-custom {
            background-color: white;
            font-weight: 600;
            color: #0f172a;
            border-bottom: 1px solid #e2e8f0;
            padding: 18px 24px;
            font-size: 1rem;
        }

        .progress {
            height: 22px;
            border-radius: 8px;
            background-color: #f1f5f9;
            font-weight: 500;
            font-size: 0.8rem;
        }

        .quick-btn {
            border-radius: 12px;
            padding: 12px 20px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }

        .quick-btn:hover {
            transform: translateY(-2px);
        }

        footer {
            background: #0f172a !important;
            color: #94a3b8 !important;
            border-radius: 16px;
            font-size: 0.88rem;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h3 class="text-center text-white mb-4">
            <i class="fas fa-shield-halved text-warning me-2"></i>Admin Center
        </h3>
        <div class="px-3"><hr class="text-secondary opacity-25 m-0 mb-3"></div>
        
        <a href="adminDashboard.jsp" class="active"><i class="fas fa-chart-line"></i> Dashboard</a>
        <a href="viewUsers.jsp"><i class="fas fa-users"></i> Users Grid</a>
        <a href="viewChildren.jsp"><i class="fas fa-child"></i> Children Vault</a>
        <a href="ViewIncidentServlet"><i class="fas fa-triangle-exclamation"></i> Incidents Log</a>
        <a href="viewFeedback.jsp"><i class="fas fa-comments"></i> User Reviews</a>
        <a href="LogoutServlet" class="mt-4 text-danger"><i class="fas fa-right-from-bracket"></i> Clear Session</a>
    </div>

    <div class="main-content">
        
        <div class="card welcome-card p-4 mb-4">
            <div class="card-body">
                <h3 class="fw-bold text-dark m-0 d-flex align-items-center">
                    <i class="fas fa-circle-user text-primary me-2"></i> Welcome Back, System Admin 👋
                </h3>
                <p class="text-muted small mb-0 mt-1">Global infrastructure status: Normal. Monitor profiles, audit data telemetry, and manage logs seamlessly.</p>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card dashboard-card p-3" style="border-top: 4px solid #2563eb;">
                    <div class="card-body text-center">
                        <div class="text-muted small fw-medium text-uppercase mb-2"><i class="fas fa-users me-1 text-primary"></i> Total Users</div>
                        <h1 class="fw-bold display-6 text-primary m-0"><%= users %></h1>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card dashboard-card p-3" style="border-top: 4px solid #16a34a;">
                    <div class="card-body text-center">
                        <div class="text-muted small fw-medium text-uppercase mb-2"><i class="fas fa-child me-1 text-success"></i> Registered Kids</div>
                        <h1 class="fw-bold display-6 text-success m-0"><%= children %></h1>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card dashboard-card p-3" style="border-top: 4px solid #dc2626;">
                    <div class="card-body text-center">
                        <div class="text-muted small fw-medium text-uppercase mb-2"><i class="fas fa-exclamation-triangle me-1 text-danger"></i> Open Tickets</div>
                        <h1 class="fw-bold display-6 text-danger m-0"><%= incidents %></h1>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card dashboard-card p-3" style="border-top: 4px solid #ca8a04;">
                    <div class="card-body text-center">
                        <div class="text-muted small fw-medium text-uppercase mb-2"><i class="fas fa-comments me-1 text-warning"></i> Feedbacks</div>
                        <h1 class="fw-bold display-6 text-warning m-0"><%= feedback %></h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-md-6">
                <div class="card dashboard-card h-100 overflow-hidden">
                    <div class="card-header-custom"><i class="fas fa-bolt text-warning me-2"></i>Recent System Activity</div>
                    <div class="card-body p-4">
                        <ul class="list-group list-group-flush gap-2">
                            <li class="list-group-item d-flex align-items-center border-0 bg-light rounded px-3 py-2.5">
                                <i class="fas fa-triangle-exclamation text-danger me-3"></i> Emergency safety incident reported to dispatchers
                            </li>
                            <li class="list-group-item d-flex align-items-center border-0 bg-light rounded px-3 py-2.5">
                                <i class="fas fa-child text-success me-3"></i> New dependent child matrix mapped inside user registry
                            </li>
                            <li class="list-group-item d-flex align-items-center border-0 bg-light rounded px-3 py-2.5">
                                <i class="fas fa-comments text-primary me-3"></i> Client satisfaction metadata log received via feedback routing
                            </li>
                            <li class="list-group-item d-flex align-items-center border-0 bg-light rounded px-3 py-2.5">
                                <i class="fas fa-circle-check text-success me-3"></i> Critical case validation resolved by support engineers
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card dashboard-card h-100">
                    <div class="card-header-custom"><i class="fas fa-chart-pie text-info me-2"></i>Resolution Vector Overview</div>
                    <div class="card-body p-4 d-flex flex-column justify-content-center">
                        
                        <div class="mb-3">
                            <div class="d-flex justify-content-between text-muted small mb-1"><span>Resolved Cases</span><span class="fw-semibold">70%</span></div>
                            <div class="progress"><div class="progress-bar bg-success shadow-sm" style="width:70%">Processed Logs</div></div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between text-muted small mb-1"><span>Pending Triages</span><span class="fw-semibold">20%</span></div>
                            <div class="progress"><div class="progress-bar bg-warning text-dark shadow-sm" style="width:20%">In Queue</div></div>
                        </div>

                        <div>
                            <div class="d-flex justify-content-between text-muted small mb-1"><span>Critical Escalations</span><span class="fw-semibold">10%</span></div>
                            <div class="progress"><div class="progress-bar bg-danger shadow-sm" style="width:10%">Immediate Attention</div></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <h4 class="fw-bold mt-5 mb-3 text-dark"><i class="fas fa-bolt-lightning text-warning me-1 small"></i> Master System Shortcuts</h4>
        <div class="d-flex flex-wrap gap-2 mb-4">
            <a href="viewUsers.jsp" class="btn btn-primary quick-btn shadow-sm"><i class="fas fa-users me-1"></i> Audit Users</a>
            <a href="viewChildren.jsp" class="btn btn-success quick-btn shadow-sm text-white"><i class="fas fa-child me-1"></i> Audit Children</a>
            <a href="ViewIncidentServlet" class="btn btn-danger quick-btn shadow-sm"><i class="fas fa-triangle-exclamation me-1"></i> Evaluate Incidents</a>
            <a href="viewFeedback.jsp" class="btn btn-info quick-btn shadow-sm text-white"><i class="fas fa-comments me-1"></i> Read Reviews</a>
        </div>

        <footer class="text-center mt-5 p-4 bg-dark shadow-sm">
            <span class="fw-semibold text-white">© 2026 Child Safety Tracking System</span>
            <div class="text-white-50 small mt-1">Institutional Administration Architecture Portal | Managed by System Engineers</div>
        </footer>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>