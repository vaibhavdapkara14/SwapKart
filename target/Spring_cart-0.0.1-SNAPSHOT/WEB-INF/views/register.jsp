<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    
<link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
    <title>Join SwapKart | Register</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #6366f1;
            --glass: rgba(255, 255, 255, 0.96);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: #0f172a;
            /* Wahi Cubes Pattern aur Dark Gradient */
            background-image: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.85)), 
                              url('https://www.transparenttextures.com/patterns/cubes.png');
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #f8fafc;
        }

        /* --- SIMPLE NAVBAR (Sirf Logo aur Buy/Login) --- */
        .navbar-custom {
            background: rgba(15, 23, 42, 0.9) !important;
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 15px 0;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 24px;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
        }

        .nav-link-custom {
            color: #f8fafc !important;
            font-weight: 600;
            margin-left: 25px;
            text-decoration: none;
            transition: 0.3s;
        }

        .nav-link-custom:hover {
            color: var(--primary) !important;
        }

        /* --- COMPACT GLASS REGISTER CARD --- */
        .reg-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
        }

        .reg-card {
            background: var(--glass);
            border-radius: 28px;
            padding: 35px 40px;
            width: 100%;
            max-width: 410px; /* Compact Size */
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .reg-title {
            font-weight: 800;
            font-size: 26px;
            color: #1e293b;
            text-align: center;
            margin-bottom: 25px;
        }

        /* Input Styling */
        .input-group {
            background: #f1f5f9;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            margin-bottom: 15px;
            transition: 0.3s;
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
            padding: 10px 15px;
            font-size: 14.5px;
            color: #1e293b;
        }

        /* Button */
        .btn-reg {
            background: linear-gradient(135deg, #6366f1, #a855f7);
            color: white !important;
            border: none;
            border-radius: 14px;
            padding: 14px;
            font-weight: 700;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;
            transition: 0.3s ease;
        }

        .btn-reg:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }

        .footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #64748b;
        }

        .footer-text a {
            color: var(--primary);
            font-weight: 700;
            text-decoration: none;
        }
    </style>
</head>
<body>

<nav class="navbar-custom">
    <div class="container d-flex justify-content-between align-items-center">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">SwapKart</a>
        <div class="d-flex">
            <a href="${pageContext.request.contextPath}/products" class="nav-link-custom">Buy</a>
            <a href="${pageContext.request.contextPath}/login" class="nav-link-custom">Login</a>
        </div>
    </div>
</nav>

<div class="reg-container">
    <div class="reg-card">
        
        <div class="reg-title">Create Account</div>

        <form action="${pageContext.request.contextPath}/doRegister" method="post">

            <div class="input-group">
                <span class="input-group-text"><i class="fa-regular fa-user"></i></span>
                <input type="text" name="fullName" class="form-control" placeholder="Full Name" required>
            </div>

            <div class="input-group">
                <span class="input-group-text"><i class="fa-regular fa-envelope"></i></span>
                <input type="email" name="email" class="form-control" placeholder="Email Address" required>
            </div>

            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                <input type="text" name="mobile" class="form-control" placeholder="Mobile Number" required>
            </div>

            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>

            <button type="submit" class="btn btn-reg">Register Now</button>

            <div class="footer-text">
                Already have an account? 
                <a href="${pageContext.request.contextPath}/login">Login Here</a>
            </div>

        </form>
    </div>
</div>

</body>
</html>