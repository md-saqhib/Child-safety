<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Child Safety Tracking System</title>

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

        .register-container {
            width: 100%;
            max-width: 950px;
        }

        .register-card {
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
        }

        .left-panel i {
            color: #fbbf24;
            filter: drop-shadow(0px 4px 10px rgba(251, 191, 36, 0.3));
        }

        .right-panel {
            background: white;
            padding: 50px 50px;
        }

        /* Modern Inputs */
        .form-control {
            border-radius: 12px;
            padding: 11px 16px;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
        }

        /* Password Toggle */
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

        .btn-register {
            width: 100%;
            border-radius: 12px;
            padding: 12px;
            font-weight: 500;
            background: #2563eb;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        .links-container a {
            color: #4f46e5;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .links-container a:hover {
            color: #2563eb;
            text-decoration: underline;
        }
        
        .error-message {
            font-size: 0.8rem;
            color: #ef4444;
            margin-top: 4px;
            display: none;
        }
    </style>
</head>
<body>

<div class="container register-container">
    <div class="row register-card g-0">
        
        <div class="col-md-5 left-panel d-none d-md-flex">
            <i class="fas fa-shield-halved fa-5x mb-4"></i>
            <h2 class="fw-bold tracking-wide">Child Safety<br>Tracking System</h2>
            <p class="text-muted mt-3 px-2" style="color: #94a3b8 !important;">
                Create your secure account to manage child profiles, log alerts, and collaborate with authorities instantly.
            </p>
        </div>

        <div class="col-md-7 right-panel">
            <h3 class="fw-bold text-dark mb-1 text-center text-md-start">Create Account</h3>
            <p class="text-muted mb-4 text-center text-md-start">Join us to build a safer network for every child.</p>

            <form action="RegisterServlet" method="post" id="registrationForm" onsubmit="return validateForm()">
                
                <div class="mb-3">
                    <label class="form-label small fw-medium text-secondary">Full Name</label>
                    <input type="text" name="fullName" class="form-control" placeholder="John Doe" required>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-medium text-secondary">Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-medium text-secondary">Phone Number</label>
                    <input type="text" id="phone" name="phone" class="form-control" placeholder="10-digit mobile number" maxlength="10" required>
                    <div id="phoneError" class="error-message"><i class="fas fa-circle-exclamation"></i> Please enter a valid 10-digit mobile number.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-medium text-secondary">Password</label>
                    <div class="input-group">
                        <input type="password" id="password" name="password" class="form-control" placeholder="Create strong password" required>
                        <button type="button" class="btn" onclick="togglePassword()">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-register mb-3">
                    Register Now <i class="fas fa-user-plus ms-2"></i>
                </button>
            </form>

            <div class="text-center links-container mt-2">
                <p class="small text-muted mb-0">Already have an account? <a href="Login.jsp" class="fw-medium">Login Here</a></p>
            </div>
        </div>

    </div>
</div>

<script>
// Toggle Password script
function togglePassword(){
    var password = document.getElementById("password");
    var eyeIcon = document.getElementById("eyeIcon");

    if(password.type === "password") {
        password.type = "text";
        eyeIcon.classList.remove("fa-eye");
        eyeIcon.classList.add("fa-eye-slash");
    } else {
        password.type = "password";
        eyeIcon.classList.remove("fa-eye-slash");
        eyeIcon.classList.add("fa-eye");
    }
}

// FIXED: Corrected range selection pattern string sequence mapping
document.getElementById('phone').addEventListener('input', function (e) {
    // Ab ye pure 0 to 9 numbers handle karega properly
    this.value = this.value.replace(/[^0-9]/g, '');
});

function validateForm() {
    var phoneInput = document.getElementById("phone").value;
    var phoneError = document.getElementById("phoneError");
    
    // Pattern to check exactly 10 digit numbers
    var phonePattern = /^[0-9]{10}$/;
    
    if(!phonePattern.test(phoneInput)) {
        phoneError.style.display = "block";
        return false; // blocks form submission
    } else {
        phoneError.style.display = "none";
        return true; // allows form submission to RegisterServlet
    }
}
</script>

</body>
</html>