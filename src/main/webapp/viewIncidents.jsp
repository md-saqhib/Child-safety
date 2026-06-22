<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Incident Management Terminal - Admin Panel</title>

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

        .control-card {
            max-width: 680px;
            margin: 30px auto;
            border: none;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
            background: white;
            overflow: hidden;
        }

        .btn-load {
            border-radius: 12px;
            padding: 14px 30px;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-load:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(220, 38, 38, 0.25);
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
        <a href="ViewIncidentServlet" class="active"><i class="fas fa-triangle-exclamation"></i> Incidents Log</a>
        <a href="viewFeedback.jsp"><i class="fas fa-comments"></i> User Reviews</a>
        <a href="LogoutServlet" class="mt-4 text-danger"><i class="fas fa-right-from-bracket"></i> Clear Session</a>
    </div>

    <div class="main-content">
        <div class="card control-card p-4 text-center">
            <div class="card-body py-5">
                
                <div class="mb-4">
                    <span class="p-4 bg-danger-subtle rounded-circle d-inline-block shadow-sm">
                        <i class="fas fa-triangle-exclamation fa-4x text-danger"></i>
                    </span>
                </div>

                <h2 class="fw-bold text-dark mb-2">Incident Management Terminal</h2>
                <p class="text-muted small px-md-4 mb-4">
                    Initialize security routing to extract real-time tracking streams, safety ticket matrix records, and threat classification logs from the master database clusters.
                </p>

                <div class="d-grid gap-2 col-sm-8 mx-auto mb-4">
                    <a href="ViewIncidentServlet" class="btn btn-danger btn-load">
                        <i class="fas fa-database me-2"></i> Fetch & Build Live Logs
                    </a>
                </div>

                <div class="px-5"><hr class="text-secondary opacity-25 my-4"></div>

                <a href="adminDashboard.jsp" class="text-decoration-none text-secondary small fw-medium">
                    <i class="fas fa-arrow-left me-1 small"></i> Cancel & Return to Base Panel
                </a>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>