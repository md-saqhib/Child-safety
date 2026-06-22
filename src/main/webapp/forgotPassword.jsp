<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Security Center - Recovery Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .recovery-card {
            border: none;
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
            background: #ffffff;
            max-width: 460px;
            width: 100%;
            padding: 35px;
        }
        .icon-header {
            width: 70px;
            height: 70px;
            background: #fef2f2;
            color: #ef4444;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin: 0 auto 20px auto;
        }
        .form-control {
            border-radius: 12px;
            padding: 10px 14px;
            border: 1px solid #e2e8f0;
            font-size: 0.95rem;
        }
        .btn-submit {
            background: #0f172a;
            color: #ffffff;
            border-radius: 12px;
            padding: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            width: 100%;
        }
        .btn-submit:hover {
            background: #1e293b;
            color: #38bdf8;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center px-3">
    <div class="card recovery-card">
        
        <div class="icon-header text-center">
            <i class="fas fa-key text-primary"></i>
        </div>
        
        <h3 class="fw-bold text-dark text-center m-0">Reset Password</h3>
        <p class="text-muted small text-center mt-2 mb-4">Enter your registered email and assign a new structural security access credentials token.</p>
        
        <form id="forgotPasswordForm" method="post" class="text-start">
            
            <div class="mb-3">
                <label class="form-label small fw-semibold text-secondary ps-1">Registered Email</label>
                <div class="input-group">
                    <span class="input-group-text bg-light text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-envelope small"></i></span>
                    <input type="email" id="email" name="email" class="form-control" style="border-radius: 0 12px 12px 0;" placeholder="name@domain.com" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label small fw-semibold text-secondary ps-1">New Secure Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light text-muted" style="border-radius: 12px 0 0 12px;"><i class="fas fa-lock small"></i></span>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" style="border-radius: 0 12px 12px 0;" placeholder="New Password" required>
                </div>
            </div>
            
            <button type="submit" class="btn btn-submit mb-2 mt-2">
                <i class="fas fa-save me-2"></i> Update Password
            </button>
            
        </form>
        
        <div class="text-center mt-3">
            <hr class="text-secondary opacity-25">
            <a href="Login.jsp" class="text-decoration-none small text-muted"><i class="fas fa-arrow-left me-1"></i> Return to Login Gate</a>
        </div>
        
    </div>
</div>

<script>
document.getElementById("forgotPasswordForm").addEventListener("submit", function(e) {
    e.preventDefault(); // Browser ka automatic blank page reload rokkega

    var emailValue = document.getElementById("email").value;
    var newPasswordValue = document.getElementById("newPassword").value;

    // Send asynchronous data to Servlet
    fetch('ForgotPasswordServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'email=' + encodeURIComponent(emailValue) + '&newPassword=' + encodeURIComponent(newPasswordValue)
    })
    .then(response => {
        // Backend update query success hone ke baad run hoga
        alert("Success: Security credentials updated successfully!");
        window.location.href = "Login.jsp"; // Smoothly redirect to Login Gate
    })
    .catch(error => {
        alert("System Error: Unable to process security reset token context request.");
        console.error(error);
    });
});
</script>

</body>
</html>