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
    <title>Feedback - Child Safety Tracking System</title>

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

        .feedback-card {
            border: none;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(217, 119, 6, 0.08);
            background: white;
            overflow: hidden;
        }

        .card-header-warning {
            background: linear-gradient(135deg, #d97706, #f59e0b);
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

        /* Modernized Form Elements */
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f8fafc;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: #f59e0b;
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.15);
        }

        .btn-submit {
            border-radius: 12px;
            padding: 14px;
            font-weight: 500;
            font-size: 1rem;
            background: #d97706;
            color: white;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: #b45309;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(217, 119, 6, 0.2);
        }

        .btn-back {
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 500;
            padding: 8px 16px;
            transition: all 0.2s;
        }

        .custom-alert {
            border-radius: 12px;
            font-size: 0.95rem;
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

                <%
                String msg = request.getParameter("msg");
                if("success".equals(msg)){
                %>
                <div class="alert alert-success alert-dismissible fade show custom-alert shadow-sm d-flex align-items-center mb-4" role="alert">
                    <i class="fas fa-check-circle me-2 fs-5"></i>
                    <div>Feedback Submitted Successfully! Thank you for helping us improve.</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                }
                %>

                <div class="card feedback-card">
                    <div class="card-header-warning text-center py-4">
                        <div class="mb-2">
                            <i class="fas fa-comments fa-3x text-white" style="opacity: 0.9;"></i>
                        </div>
                        <h3 class="fw-bold m-0 text-white">Share Your Feedback</h3>
                        <p class="text-white-50 small mb-0 mt-1">Your reviews, feature requests, and suggestions help optimize safety compliance.</p>
                    </div>

                    <div class="card-body p-5">
                        
                        <form action="FeedbackServlet" method="post">

                            <div class="mb-4">
                                <label class="form-label">Your Message / Suggestions</label>
                                <textarea name="message" class="form-control" rows="6" placeholder="Write your valuable feedback or platform recommendations here..." style="resize: none;" required></textarea>
                            </div>

                            <button type="submit" class="btn btn-warning btn-submit w-100">
                                <i class="fas fa-paper-plane me-2"></i> Submit Feedback
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