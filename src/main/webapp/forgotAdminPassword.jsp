<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Admin Password - Child Safety Tracking System</title>

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

        .reset-card {
            width: 850px;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            border: none;
            background: transparent;
        }

        .left-panel {
            background: linear-gradient(135deg, #1e293b, #0f172a);
            color: white;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            border-right: 1px solid rgba(255, 255, 255, 0.05);
        }

        .right-panel {
            background: white;
            padding: 50px;
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
            border-color: #0f172a;
            box-shadow: 0 0 0 4px rgba(15, 23, 42, 0.15);
        }

        .input-group-text {
            background-color: #f8fafc;
            border-color: #cbd5e1;
            border-radius: 12px 0 0 12px;
            color: #64748b;
        }

        .btn-reset {
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

        .btn-reset:hover {
            transform: translateY(-2px);
            background: #1e293b;
            box-shadow: 0 5px 15px rgba(15, 23, 42, 0.3);
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
    <div class="row reset-card w-100 m-2">

        <div class="col-md-5 left-panel d-none d-md-flex">
            <div class="mb-3">
                <i class="fas fa-key-skeleton fa-4x text-warning" style="opacity: 0.9;"></i>
            </div>
            <h3 class="fw-bold text-white m-0">Credential Reset</h3>
            <p class="text-white-50 small mt-2">
                Verify identity parameters to override system passphrases securely.
            </p>
        </div>

        <div class="col-md-7 right-panel">
            
            <h3 class="fw-bold text-dark text-center mb-1">Reset Password</h3>
            <p class="text-muted text-center small mb-4">Modify your account authorization key matrix.</p>

            <form action="ForgotAdminPasswordServlet" method="post">

                <div class="mb-3">
                    <label class="form-label">Admin Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user-shield small"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Enter administrative username" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Enter New Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock small"></i></span>
                        <input type="password" id="password" name="newPassword" class="form-control" placeholder="Enter secure new passphrase" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-dark btn-reset mb-3">
                    <i class="fas fa-rotate me-2"></i> Reset Credentials
                </button>

            </form>

            <div class="text-center mt-2">
                <a href="adminLogin.jsp" class="link-text small fw-medium text-primary">
                    <i class="fas fa-arrow-left me-1 small"></i> Back to Admin Login
                </a>
            </div>

        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>