<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Dbconnection" %>

<%
int totalUsers = 0;
int totalChildren = 0;
int totalIncidents = 0;

try{

Connection con = Dbconnection.getConnection();

Statement st = con.createStatement();

ResultSet rs1 =
st.executeQuery("SELECT COUNT(*) FROM users");

if(rs1.next())
totalUsers = rs1.getInt(1);

ResultSet rs2 =
st.executeQuery("SELECT COUNT(*) FROM child");

if(rs2.next())
totalChildren = rs2.getInt(1);

ResultSet rs3 =
st.executeQuery("SELECT COUNT(*) FROM incidents");

if(rs3.next())
totalIncidents = rs3.getInt(1);

}catch(Exception e){
e.printStackTrace();
}
%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Child Safety Tracking System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f8fafc;
            color: #334155;
            margin: 0;
            padding: 0;
        }

        /* Navbar */
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        /* Modern Caret Smoothness for Admin Dropdown */
        .dropdown-menu {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 8px;
        }
        .dropdown-item {
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }
        .dropdown-item:hover {
            background-color: #f1f5f9;
            color: #1e40af;
        }

        /* Hero Section - Isolated properly */
        .hero-section {
            background: linear-gradient(135deg, #1e40af, #6d28d9);
            color: white;
            padding: 90px 0 130px 0;
            position: relative;
        }

        .hero-section h1 {
            animation: slideDown 0.8s ease-out;
        }

        .hero-section p {
            animation: fadeIn 1.5s ease-in;
            color: #e2e8f0;
        }

        /* Stats Section Overlapping Container */
        .stats-container {
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }

        .stats-card {
            border: none;
            border-radius: 16px;
            background: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.15) !important;
        }

        /* Features */
        .feature-card {
            transition: all 0.3s ease;
            border: none;
            border-radius: 16px;
            background: white;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1) !important;
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: inline-block;
        }

        /* Common Padding for Sections */
        .custom-padding {
            padding: 80px 0;
        }

        .contact-box {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            max-width: 500px;
            margin: 0 auto;
        }

        /* FOOTER FIX: Pure Deep Dark Background & High Contrast Text */
        .main-footer {
            background: #0f172a !important;
            color: #94a3b8 !important;
            padding: 40px 0 25px 0;
            margin-top: 0;
            border-top: 1px solid #1e293b;
        }
        
        .main-footer h5 {
            color: #ffffff !important;
            font-weight: 600;
        }

        .main-footer p {
            color: #94a3b8 !important;
        }

        .main-footer hr {
            border-color: #334155 !important;
            opacity: 0.5;
        }

        /* Animations */
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
                <i class="bi bi-shield-fill-check text-warning me-2"></i> Child Safety System
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link px-3" href="#about">About Us</a></li>
                    <li class="nav-item"><a class="nav-link px-3" href="#features">Features</a></li>
                    <li class="nav-item"><a class="nav-link px-3 me-3" href="#contact">Contact</a></li>
                    
                    <li class="nav-item dropdown my-2 my-lg-0 me-2">
                        <a class="btn btn-outline-light px-4"
   id="loginDropdown"
   role="button"
   data-bs-toggle="dropdown"
   aria-expanded="false">
                            Login Portal <i class="bi bi-chevron-down small ms-1"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end mt-2" aria-labelledby="loginDropdown">
                            <li>
                                <a class="dropdown-item d-flex align-items-center py-2" href="Login.jsp">
                                    <i class="bi bi-person-circle text-primary fs-5 me-2"></i>
                                    <div>
                                        <span class="d-block fw-semibold text-dark">User Login</span>
                                        <small class="text-muted" style="font-size: 0.75rem;">For Parents & Guardians</small>
                                    </div>
                                </a>
                            </li>
                            <li><hr class="dropdown-divider opacity-50"></li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center py-2" href="adminLogin.jsp">
                                    <i class="bi bi-shield-lock-fill text-danger fs-5 me-2"></i>
                                    <div>
                                        <span class="d-block fw-semibold text-dark">Admin Gateway</span>
                                        <small class="text-muted" style="font-size: 0.75rem;">System Control Panel</small>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a href="register.jsp" class="btn btn-warning px-4 fw-medium">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-md-7 text-center text-md-start">
                    <h1 class="display-4 fw-bold lh-base">
                        Protecting Every Child,<br><span class="text-warning">Every Moment</span>
                    </h1>
                    <p class="lead mt-3 fs-5">
                        A smart platform for reporting, tracking, and resolving child safety incidents with absolute transparency and speed.
                    </p>
                    <a href="Login.jsp" class="btn btn-light btn-lg mt-4 px-5 py-3 fw-bold text-primary shadow">
                        Get Started <i class="bi bi-arrow-right ms-2"></i>
                    </a>
                </div>
                <div class="col-md-5 text-center d-none d-md-block">
                    <i class="bi bi-shield-check text-white-50" style="font-size: 160px; filter: drop-shadow(0px 10px 20px rgba(0,0,0,0.2));"></i>
                </div>
            </div>
        </div>
    </section>

    <section class="container stats-container">
        <div class="row text-center g-4">
            <div class="col-md-4">
                <div class="card stats-card shadow p-3">
                    <div class="card-body">
                        <div class="text-primary mb-2"><i class="bi bi-people-fill fs-2"></i></div>
                       <h2 class="fw-bold text-dark m-0">
<%= totalChildren %>
</h2>
                        <p class="text-muted mb-0 mt-1 fw-medium">Children Registered</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card shadow p-3">
                    <div class="card-body">
                        <div class="text-danger mb-2"><i class="bi bi-exclamation-triangle-fill fs-2"></i></div>
                        <h2 class="fw-bold text-dark m-0">
<%= totalIncidents %>
</h2>
                        <p class="text-muted mb-0 mt-1 fw-medium">Incidents Reported</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card shadow p-3">
                    <div class="card-body">
                        <div class="text-success mb-2"><i class="bi bi-check-circle-fill fs-2"></i></div>
                        <h2 class="fw-bold text-dark m-0">
<%= totalUsers %>
</h2>
                        <p class="text-muted mb-0 mt-1 fw-medium">Incidents Resolved</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="features" class="container custom-padding">
        <h2 class="text-center fw-bold mb-2">Our Key Features</h2>
        <p class="text-center text-muted mb-5">Advanced tools engineered for prompt actions and secure data management.</p>
        
        <div class="row g-4">
            <div class="col-md-3">
                <div class="card feature-card h-100 shadow-sm p-3">
                    <div class="card-body text-center">
                        <div class="text-primary feature-icon">
                            <i class="bi bi-person-plus-fill"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Add Child</h5>
                        <p class="text-muted small">Register and manage vital child information with enterprise-grade security.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card feature-card h-100 shadow-sm p-3">
                    <div class="card-body text-center">
                        <div class="text-danger feature-icon">
                            <i class="bi bi-bell-fill"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Report Incident</h5>
                        <p class="text-muted small">Instantly log safety alerts or incidents to push them directly to authorities.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card feature-card h-100 shadow-sm p-3">
                    <div class="card-body text-center">
                        <div class="text-warning feature-icon">
                            <i class="bi bi-geo-alt-fill"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Track Status</h5>
                        <p class="text-muted small">Get real-time tracking updates and clear transparency on investigations.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card feature-card h-100 shadow-sm p-3">
                    <div class="card-body text-center">
                        <div class="text-info feature-icon">
                            <i class="bi bi-chat-left-heart-fill"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Feedback</h5>
                        <p class="text-muted small">Continuous interaction via open suggestions to systematically improve safety protocols.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="about" class="bg-white custom-padding border-top">
        <div class="container text-center" style="max-width: 800px;">
            <h2 class="fw-bold mb-4">About Us</h2>
            <p class="lead text-muted lh-base fs-6">
                The <strong>Child Safety Tracking System</strong> is an end-to-end framework built to establish a reliable bridge between parents, schools, and safety administrators. We enable proactive incident logging, real-time ticket escalation, and rigorous accountability to construct a secure environment for every child.
            </p>
        </div>
    </section>

    <section id="contact" class="custom-padding bg-light border-top">
        <div class="container text-center">
            <h2 class="fw-bold mb-4">Contact Us</h2>
            <p class="text-muted mb-4">Have questions or require help with the system? Reach out to our dedicated support desk.</p>
            <div class="contact-box p-4 shadow-sm">
                <div class="d-flex align-items-center justify-content-center gap-2 mb-3">
                    <i class="bi bi-envelope-fill text-primary fs-5"></i>
                    <span class="fw-semibold text-dark">support@childsafety.com</span>
                </div>
                <div class="d-flex align-items-center justify-content-center gap-2">
                    <i class="bi bi-telephone-fill text-success fs-5"></i>
                    <span class="fw-semibold text-dark">+91 9876543210</span>
                </div>
            </div>
        </div>
    </section>

    <footer class="main-footer">
        <div class="container text-center">
            <h5>Child Safety Tracking System</h5>
            <p class="small mt-2 mb-4">
                Ensuring safer environments for children through smart incident reporting and monitoring.
            </p>
            <hr class="my-4">
            <p class="small m-0">
                &copy; 2026 Child Safety Tracking System | Developed by MCA Student
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>