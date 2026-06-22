<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Child Safety Tracking System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
        }

        .login-card {
            width: 900px;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            border: none;
            background: transparent;
        }

        .left-panel {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            border-right: 1px solid rgba(255, 255, 255, 0.05);
        }

        .right-panel {
            background: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #475569;
            margin-bottom: 6px;
        }

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
            border-color: #334155;
            box-shadow: 0 0 0 4px rgba(51, 65, 85, 0.15);
        }

        .input-group-text {
            background-color: #f8fafc;
            border-color: #cbd5e1;
            border-radius: 12px 0 0 12px;
            color: #64748b;
        }

        .btn-login {
            width: 100%;
            border-radius: 12px;
            padding: 14px;
            font-weight: 500;
            font-size: 1rem;
            background: #0f172a;
            color: white;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            background: #1e293b;
            box-shadow: 0 5px 15px rgba(15, 23, 42, 0.3);
        }

        .custom-alert {
            border-radius: 12px;
            font-size: 0.88rem;
            padding: 12px;
        }

        .link-text {
            font-size: 0.9rem;
            text-decoration: none;
            color: #64748b;
            transition: color 0.2s;
        }

        .link-text:hover {
            color: #0f172a;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="row login-card w-100 m-2">

        <div class="col-md-6 left-panel d-none d-md-flex">
            <div class="mb-4">
                <i class="fas fa-user-shield fa-5x text-warning" style="opacity: 0.95;"></i>
            </div>
            <h2 class="fw-bold text-white m-0">Admin Panel</h2>
            <p class="text-white-50 small mt-2 max-w-xs">
                Secure Access for System Administration, Compliance Management, and Database Auditing.
            </p>
        </div>

        <div class="col-md-6 right-panel">
            
            <h3 class="fw-bold text-dark text-center mb-2">Admin Login</h3>
            <p class="text-muted text-center small mb-4">Enter system parameters to verify identity matrix.</p>

            <%
            String error = request.getParameter("error");
            if("invalid".equals(error)){
            %>
            <div class="alert alert-danger custom-alert text-center mb-4 shadow-sm" role="alert">
                <i class="fas fa-exclamation-circle me-1"></i> Invalid Admin Username or Password
            </div>
            <%
            }
            if("server".equals(error)){
            %>
            <div class="alert alert-warning custom-alert text-center mb-4 shadow-sm" role="alert">
                <i class="fas fa-triangle-exclamation me-1"></i> Server Error. Try Again Later.
            </div>
            <%
            }
            %>

            <form action="AdminLoginServlet" method="post">

                <div class="mb-3">
                    <label class="form-label">Admin Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user-gear small"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Enter admin credentials" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock small"></i></span>
                        <input type="password" id="password" name="password" class="form-control border-end-0" placeholder="Enter security passphrase" required>
                        <button type="button" class="btn btn-outline-secondary bg-light border border-start-0 text-muted" style="border-radius: 0 12px 12px 0; border-color: #cbd5e1 !important;" onclick="togglePassword()">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn btn-dark btn-login mb-3">
                    <i class="fas fa-right-to-bracket me-2"></i> Authenticate Log
                </button>

            </form>

            <div class="d-flex justify-content-between align-items-center mt-2 px-1">
                <a href="forgotAdminPassword.jsp" class="link-text small">
                    <i class="fas fa-key me-1 small"></i> Forgot Password?
                </a>
                <a href="Login.jsp" class="link-text small fw-medium text-primary">
                    User Login <i class="fas fa-arrow-right-to-bracket ms-1 small"></i>
                </a>
            </div>

        </div>

    </div>
</div>

<script>
function togglePassword(){
    var password = document.getElementById("password");
    var eyeIcon = document.getElementById("eyeIcon");

    if(password.type === "password"){
        password.type = "text";
        eyeIcon.classList.remove("fa-eye");
        eyeIcon.classList.add("fa-eye-slash");
    } else {
        password.type = "password";
        eyeIcon.classList.remove("fa-eye-slash");
        eyeIcon.classList.add("fa-eye");
    }
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>