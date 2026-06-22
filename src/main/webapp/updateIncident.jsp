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
    <title>Update Incident Status - Admin Panel</title>

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

        .form-card {
            max-width: 600px;
            margin: 30px auto;
            border: none;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
            background: white;
            overflow: hidden;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #475569;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f8fafc;
        }

        .form-control:focus, .form-select:focus {
            background-color: #ffffff;
            border-color: #2563eb;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.15);
        }

        .btn-update {
            border-radius: 12px;
            padding: 14px;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(15, 23, 42, 0.15);
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
        <div class="card form-card shadow-sm">
            
            <div class="p-4 border-bottom bg-light">
                <h3 class="fw-bold m-0 text-dark d-flex align-items-center">
                    <i class="fas fa-pen-to-square text-primary me-2"></i> Update Ticket Status
                </h3>
                <p class="text-muted small mb-0 mt-1">Modify triage escalation tags for registered case incidents.</p>
            </div>

            <div class="card-body p-4">
                
                <form action="UpdateIncidentServlet" method="post">

                    <div class="mb-3">
                        <label class="form-label">Incident Tracking ID</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-hashtag small"></i></span>
                            <input type="number" name="incidentId" class="form-control" style="border-radius: 0 12px 12px 0;" placeholder="e.g. 1042" required>
                        </div>
                        <div class="form-text small text-muted">Verify the reference ticket key from your primary incident log matrix.</div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Update State Vector</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-signal small"></i></span>
                            <select name="status" class="form-select" style="border-radius: 0 12px 12px 0;">
                                <option value="Pending" class="text-danger fw-medium">🔴 Pending Triage</option>
                                <option value="In Progress" class="text-warning fw-medium">🟡 Evaluation In Progress</option>
                                <option value="Resolved" class="text-success fw-medium">🟢 Case Resolved</option>
                            </select>
                        </div>
                    </div>

                    <div class="row g-2 mt-2">
                        <div class="col-sm-4">
                            <a href="adminDashboard.jsp" class="btn btn-light border w-100 py-2.5 text-secondary" style="border-radius: 12px;">Cancel</a>
                        </div>
                        <div class="col-sm-8">
                            <button type="submit" class="btn btn-dark btn-update w-100 py-2.5">
                                <i class="fas fa-rotate me-1"></i> Push Lifecycle Update
                            </button>
                        </div>
                    </div>

                </form>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>