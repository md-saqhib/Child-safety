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
    <title>Report Incident - Child Safety Tracking System</title>

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

        .incident-card {
            border: none;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(239, 68, 68, 0.08);
            background: white;
            overflow: hidden;
        }

        .card-header-alert {
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            color: white;
            padding: 25px text-center;
            border: none;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #475569;
            margin-bottom: 6px;
        }

        /* Modernized Inputs & Selection elements */
        .form-control,
        .form-select {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f8fafc;
        }

        .form-control:focus,
        .form-select:focus {
            background-color: #ffffff;
            border-color: #ef4444;
            box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.12);
        }

        .btn-submit {
            border-radius: 12px;
            padding: 14px;
            font-weight: 500;
            font-size: 1rem;
            background: #dc2626;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: #b91c1c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 38, 38, 0.2);
        }

        .btn-back {
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 500;
            padding: 8px 16px;
            transition: all 0.2s;
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
        <div class="row justify-content-center">
            <div class="col-md-8">
                
                <div class="card incident-card">
                    <div class="card-header-alert text-center py-4">
                        <div class="mb-2">
                            <i class="fas fa-triangle-exclamation fa-3x text-warning"></i>
                        </div>
                        <h3 class="fw-bold m-0">Incident Report Form</h3>
                        <p class="text-white-50 small mb-0 mt-1">Provide critical emergency details. All reports are immediately sent to administration triage.</p>
                    </div>

                    <div class="card-body p-5">
                        
                        <form action="ReportIncidentServlet" method="post">

                            <div class="mb-4">
                                <label class="form-label">Select Registered Child</label>
                                <select name="childId" class="form-select" required>
                                    <option value="">-- Click to choose profile --</option>
                                    <%
                                    try {
                                        Connection con = Dbconnection.getConnection();
                                        PreparedStatement ps = con.prepareStatement(
                                            "SELECT child_id, child_name FROM child WHERE user_id=?"
                                        );
                                        ps.setInt(1, userId);
                                        ResultSet rs = ps.executeQuery();

                                        while(rs.next()){
                                    %>
                                    <option value="<%= rs.getInt("child_id") %>">
                                        <%= rs.getString("child_name") %> (ID: #<%= rs.getInt("child_id") %>)
                                    </option>
                                    <%
                                        }
                                    } catch(Exception e) {
                                        e.printStackTrace();
                                    }
                                    %>
                                </select>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Incident Type / Category</label>
                                    <select name="incidentType" class="form-select">
                                        <option value="Abuse">Abuse</option>
                                        <option value="Bullying">Bullying</option>
                                        <option value="Missing Child">Missing Child</option>
                                        <option value="Harassment">Harassment</option>
                                        <option value="Accident">Accident</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Brief Title Summary</label>
                                    <input type="text" name="title" class="form-control" placeholder="e.g., Missing since afternoon" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Exact Location or Landmark</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0 text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-location-dot small"></i></span>
                                    <input type="text" name="location" class="form-control border-start-0" style="border-radius: 0 12px 12px 0;" placeholder="Enter specific location details" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Comprehensive Description</label>
                                <textarea name="description" class="form-control" rows="4" placeholder="Describe the incident in full detail (clothing, timelines, witnesses, etc.)" style="resize: none;" required></textarea>
                            </div>

                            <button type="submit" class="btn btn-danger btn-submit text-white w-100 mt-2">
                                <i class="fas fa-paper-plane me-2"></i> Broadcast Incident Report
                            </button>

                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>