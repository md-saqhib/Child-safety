<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String email = (String)session.getAttribute("email");
if(email == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Incident - Child Safety Tracking System</title>

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

        .search-card {
            max-width: 650px;
            margin: 60px auto;
            border: none;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.05);
            background: white;
            overflow: hidden;
        }

        .card-header-search {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: white;
            padding: 30px text-center;
            border: none;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #475569;
            margin-bottom: 8px;
            display: block;
        }

        /* Modernized Form Elements */
        .form-control {
            border-radius: 12px;
            padding: 14px 18px;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f8fafc;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: #2563eb;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.15);
        }

        .btn-search {
            border-radius: 12px;
            padding: 12px 25px;
            font-weight: 500;
            background: #2563eb;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.2);
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

    <div class="container">
        <div class="card search-card">
            
            <div class="card-header-search text-center py-4">
                <div class="mb-2">
                    <i class="fas fa-magnifying-glass fa-3x text-warning"></i>
                </div>
                <h3 class="fw-bold m-0 text-white">Advanced Ticket Search</h3>
                <p class="text-white-50 small mb-0 mt-1">Lookup historical incident metrics by mapping registered profile records.</p>
            </div>

            <div class="card-body p-5">
                
                <form action="SearchIncidentServlet" method="get">
                    
                    <div class="mb-4">
                        <label class="form-label">Search Incident By Child Name</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-user small"></i></span>
                            <input type="text" name="childName" class="form-control border-start-0" style="border-radius: 0 12px 12px 0;" placeholder="Enter complete or partial child name..." required>
                        </div>
                        <div class="form-text text-muted small mt-2">
                            <i class="fas fa-info-circle me-1"></i> System parameters will match string tokens against your tracked records.
                        </div>
                    </div>

                    <div class="d-flex gap-3 justify-content-end align-items-center mt-2">
                        <a href="userDashboard.jsp" class="btn btn-light text-secondary border px-4" style="border-radius: 12px; padding: 12px;">Cancel</a>
                        <button type="submit" class="btn btn-primary btn-search text-white px-4">
                            <i class="fas fa-search me-2"></i> Search
                        </button>
                    </div>

                </form>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>