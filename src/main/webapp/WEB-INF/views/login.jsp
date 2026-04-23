<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
    <title>Login | SwapKart</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        :root {
            --primary: #6366f1;
            --secondary: #a855f7;
            --glass: rgba(255, 255, 255, 0.95);
            --error: #ef4444;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: #0f172a;
            background-image: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.85)), 
                              url('https://www.transparenttextures.com/patterns/cubes.png');
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #f8fafc;
            overflow-x: hidden;
        }

        .navbar-custom {
            background: rgba(15, 23, 42, 0.9) !important;
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 12px 0;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 24px;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-auth-btn {
            background: rgba(255, 255, 255, 0.05);
            color: #fff !important;
            border-radius: 12px;
            padding: 8px 22px !important;
            border: 1px solid rgba(255, 255, 255, 0.1);
            font-weight: 600;
            transition: 0.3s ease;
        }

        .nav-auth-btn:hover {
            background: var(--primary);
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: var(--glass);
            border-radius: 28px;
            padding: 35px 40px;
            width: 100%;
            max-width: 400px; 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-title {
            font-weight: 800;
            font-size: 26px;
            color: #1e293b;
            margin-bottom: 5px;
        }

        .login-subtitle {
            color: #64748b;
            font-size: 14px;
        }

        /* Input Styling with Validation support */
        .input-group {
            background: #f1f5f9;
            border-radius: 14px;
            border: 1.5px solid #e2e8f0;
            margin-bottom: 18px;
            transition: 0.3s;
            overflow: hidden;
        }

        .input-group.invalid-field {
            border-color: var(--error);
            background: #fff5f5;
        }

        .input-group:focus-within {
            background: #fff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        .input-group-text {
            background: transparent;
            border: none;
            color: var(--primary);
            padding-left: 18px;
        }

        .form-control {
            background: transparent !important;
            border: none !important;
            padding: 12px 15px;
            font-size: 15px;
            font-weight: 500;
            color: #1e293b;
            box-shadow: none !important;
        }

        .form-control::placeholder { color: #94a3b8; }

        .password-toggle {
            cursor: pointer;
            padding-right: 18px;
            color: #94a3b8;
            transition: 0.2s;
        }
        .password-toggle:hover { color: var(--primary); }

        .alert-custom {
            background: #fee2e2;
            color: #b91c1c;
            border: none;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            padding: 10px;
            text-align: center;
        }

        .btn-login {
            background: linear-gradient(135deg, #6366f1, #a855f7);
            color: white;
            border: none;
            border-radius: 14px;
            padding: 14px;
            font-weight: 700;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;
            transition: 0.3s ease;
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.2);
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(99, 102, 241, 0.3);
            color: white;
        }

        .footer-links {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: #64748b;
        }

        .footer-links a {
            color: var(--primary);
            font-weight: 700;
            text-decoration: none;
        }

        .forgot-pass {
            display: block;
            text-align: right;
            font-size: 13px;
            margin-top: -10px;
            margin-bottom: 20px;
            color: var(--primary);
            font-weight: 600;
        }

        /* Mobile adjustments */
        @media (max-width: 480px) {
            .login-card { padding: 25px 20px; }
            .login-title { font-size: 22px; }
        }
    </style>
</head>

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<nav class="navbar navbar-expand-lg navbar-custom sticky-top animate__animated animate__fadeInDown">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fa-solid fa-bolt-lightning me-2 text-warning"></i>SwapKart
        </a>
        
        <div class="ms-auto">
            <a href="${pageContext.request.contextPath}/register" class="nav-auth-btn text-decoration-none">
                <i class="fa-solid fa-user-plus me-1"></i> Sign Up
            </a>
        </div>
    </div>
</nav>

<div class="login-container">
    <div class="login-card animate__animated animate__zoomIn">
        
        <div class="login-header">
            <div class="login-title">Welcome Back 👋</div>
            <div class="login-subtitle">Sign in to continue swapping.</div>
        </div>

        <!-- JS Error Box -->
        <div id="jsError" class="alert alert-custom d-none animate__animated animate__headShake mb-3"></div>

        <!-- Server Error Msg -->
        <c:if test="${not empty sessionScope.msg}">
            <div class="alert alert-custom animate__animated animate__shakeX mb-3">
                <i class="fa-solid fa-circle-exclamation me-1"></i> ${sessionScope.msg}
            </div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <form id="loginForm" method="post" action="${pageContext.request.contextPath}/doLogin">
            
            <div class="input-group" id="emailGroup">
                <span class="input-group-text"><i class="fa-regular fa-envelope"></i></span>
                <input type="email" name="email" class="form-control" placeholder="Email Address" id="emailField" autocomplete="email">
            </div>

            <div class="input-group" id="passGroup">
                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                <input type="password" name="password" class="form-control" placeholder="Password" id="passField">
                <span class="input-group-text password-toggle" onclick="togglePassword()">
                    <i class="fa-solid fa-eye" id="eyeIcon"></i>
                </span>
            </div>

            <a href="${pageContext.request.contextPath}/forgotPassword" class="forgot-pass text-decoration-none">Forgot Password?</a>

            <button type="submit" class="btn btn-login shadow">
                Sign In <i class="fa-solid fa-arrow-right-to-bracket ms-1"></i>
            </button>

            <div class="footer-links">
                New here? <a href="${pageContext.request.contextPath}/register">Create Account</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const loginForm = document.getElementById("loginForm");
    const emailField = document.getElementById("emailField");
    const passField = document.getElementById("passField");
    const jsError = document.getElementById("jsError");
    const emailGroup = document.getElementById("emailGroup");
    const passGroup = document.getElementById("passGroup");

    function showError(msg, group) {
        jsError.innerHTML = '<i class="fa-solid fa-triangle-exclamation me-1"></i> ' + msg;
        jsError.classList.remove("d-none");
        if(group) group.classList.add("invalid-field");
    }

    function resetErrors() {
        jsError.classList.add("d-none");
        emailGroup.classList.remove("invalid-field");
        passGroup.classList.remove("invalid-field");
    }

    // Toggle Password Visibility
    function togglePassword() {
        const icon = document.getElementById("eyeIcon");
        if (passField.type === "password") {
            passField.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            passField.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    }

    // Real-time cleanup as user types
    [emailField, passField].forEach(field => {
        field.addEventListener('input', resetErrors);
    });

    // Form Submit Validation
    loginForm.onsubmit = function(event) {
        resetErrors();
        const email = emailField.value.trim();
        const password = passField.value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (email === "") {
            showError("Please enter your email.", emailGroup);
            event.preventDefault();
            return false;
        }

        if (!emailRegex.test(email)) {
            showError("Please enter a valid email address.", emailGroup);
            event.preventDefault();
            return false;
        }

        if (password === "") {
            showError("Password is required to sign in.", passGroup);
            event.preventDefault();
            return false;
        }

        if (password.length < 4) {
            showError("Security check: Password must be at least 4 digits.", passGroup);
            event.preventDefault();
            return false;
        }

        return true;
    };
</script>

</body>
</html>