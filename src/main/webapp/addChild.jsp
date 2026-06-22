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
    <title>Add Child - Child Safety Tracking System</title>

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

        .child-card {
            max-width: 700px;
            margin: 50px auto;
            border: none;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
            background: white;
            overflow: hidden;
        }

        .card-header-gradient {
            background: linear-gradient(135deg, #1e40af, #3b82f6);
            color: white;
            padding: 30px text-center;
            border: none;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #475569;
            margin-bottom: 6px;
        }

        /* Modernized Inputs & Form Elements */
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
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.12);
        }

        .btn-submit {
            border-radius: 12px;
            padding: 14px;
            font-weight: 500;
            font-size: 1rem;
            background: #2563eb;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
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

    <div class="card child-card">
        <div class="card-header-gradient text-center py-4">
            <div class="mb-2">
                <i class="fas fa-child-reaching fa-3x text-warning"></i>
            </div>
            <h3 class="fw-bold m-0">Register Child Details</h3>
            <p class="text-white-50 small mb-0 mt-1">Please fill in accurate identification details for records mapping.</p>
        </div>

        <div class="card-body p-5">
            
            <form action="AddChildServlet" method="post">

                <div class="mb-4">
                    <label class="form-label">Child Full Name</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-user small"></i></span>
                        <input type="text" name="childName" class="form-control border-start-0" style="border-radius: 0 12px 12px 0;" placeholder="Enter child's full name" required>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label class="form-label">Age (Years)</label>
                        <input type="number" name="age" class="form-control" placeholder="e.g. 8" min="1" max="18" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Gender</label>
                        <select name="gender" class="form-select">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">School Name / Institution</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-school small"></i></span>
                        <input type="text" name="schoolName" class="form-control border-start-0" style="border-radius: 0 12px 12px 0;" placeholder="Enter current school name">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Residential Address</label>
                    <textarea name="address" rows="3" class="form-control" placeholder="Enter complete residential address details" style="resize: none;"></textarea>
                </div>

                <button type="submit" class="btn btn-primary btn-submit text-white w-100 mt-2">
                    <i class="fas fa-plus-circle me-2"></i> Save Profile Details
                </button>

            </form>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>