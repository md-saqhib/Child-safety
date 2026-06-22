<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Child Safety Tracking System</title>
    <link rel="icon"
href="https://cdn-icons-png.flaticon.com/512/3064/3064197.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #1e40af, #6d28d9);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 950px;
        }

        .login-card {
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            background: white;
            border: none;
        }

        .left-panel {
            background: #0f172a;
            color: white;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
        }

        .left-panel i {
            color: #fbbf24;
            filter: drop-shadow(0px 4px 10px rgba(251, 191, 36, 0.3));
        }

        .right-panel {
            background: white;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* Modern Input Styling */
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
        }

        /* Password Toggle Styling Fix */
        .input-group .btn {
            border-top-right-radius: 12px !important;
            border-bottom-right-radius: 12px !important;
            border: 1px solid #cbd5e1;
            border-left: none;
            background: #f8fafc;
            color: #64748b;
        }

        .input-group .form-control {
            border-top-right-radius: 0 !important;
            border-bottom-right-radius: 0 !important;
        }

        .btn-login {
            width: 100%;
            border-radius: 12px;
            padding: 12px;
            font-weight: 500;
            background: #2563eb;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        .links-container a {
            color: #4f46e5;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.2s;
        }

        .links-container a:hover {
            color: #2563eb;
            text-decoration: underline;
        }

        /* Alert Tweaks */
        .custom-alert {
            border-radius: 12px;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container login-container">
    <div class="row login-card g-0">
        
        <div class="col-md-6 left-panel d-none d-md-flex">
            <i class="fas fa-shield-halved fa-5x mb-4"></i>
            <h2 class="fw-bold tracking-wide">Child Safety<br>Tracking System</h2>
            <p class="text-muted mt-3 px-3" style="color: #94a3b8 !important;">
                Protecting children and facilitating rapid response workflows through smart incident parameters.
            </p>
        </div>

        <div class="col-md-6 right-panel">
            <h3 class="fw-bold text-dark mb-2 text-center text-md-start">Welcome Back</h3>
            <p class="text-muted mb-4 text-center text-md-start">Please sign in to access your dashboard.</p>

            <%
            String msg = request.getParameter("msg");
            if("registered".equals(msg)){
            %>
            <div class="alert alert-success custom-alert d-flex align-items-center" role="alert">
                <i class="fas fa-check-circle me-2"></i> Registration Successful! Please Login.
            </div>
            <%
            }
            %>

            <%
            String error = request.getParameter("error");
            if("invalid".equals(error)){
            %>
            <div class="alert alert-danger custom-alert d-flex align-items-center" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> Invalid Email or Password
            </div>
            <%
            }
            %>

            <form action="LoginServlet" method="post" id="loginForm">
    
    <div class="mb-3">
        <label class="form-label">Email Address</label>
        <input type="email" name="email" class="form-control" placeholder="name@domain.com" required>
    </div>
    
    <div class="mb-4">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Password" required>
    </div>
    
    <button type="submit" class="btn btn-primary w-100 py-2.5 fw-medium" id="loginBtn">
        <i class="fas fa-right-to-bracket me-2"></i> Sign In
    </button>
    
</form>

            <div class="text-center links-container mt-2">
                <a href="forgotPassword.jsp">Forgot Password?</a>
                <hr class="text-muted my-3 opacity-25">
                <p class="small text-muted mb-0">Don't have an account? <a href="register.jsp" class="fw-medium">Register Here</a></p>
            </div>
        </div>

    </div>
</div>

<script>
document.querySelector("form").addEventListener("submit",function(){

document.getElementById("loginBtn").innerHTML=
'<span class="spinner-border spinner-border-sm"></span> Signing In...';

});

</script>

</body>
</html>