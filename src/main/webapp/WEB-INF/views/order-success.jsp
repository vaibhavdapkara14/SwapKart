<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- 1. Mobile Meta Tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<div class="container d-flex align-items-center justify-content-center min-vh-100 py-5">
    
    <div class="sk-card p-4 p-md-5 shadow-lg text-center animate__animated animate__zoomIn border-0" style="max-width: 500px; width: 100%;">
        
        <!-- Animated Success Icon -->
        <div class="mb-4">
            <div class="success-icon-circle mx-auto d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-circle-check fa-5x text-success animate__animated animate__bounceIn"></i>
            </div>
        </div>

        <!-- Heading -->
        <h1 class="fw-800 mb-3" style="font-size: clamp(1.8rem, 5vw, 2.5rem);">Payment Success!</h1>
        
        <!-- Message -->
        <p class="text-muted mb-4 px-2" style="font-size: 16px; line-height: 1.6;">
            Bhai, badhai ho! Tera payment confirm ho gaya hai. Seller ko notify kar diya gaya hai aur tera order process ho raha hai.
        </p>

        <!-- Order ID/TXN Placeholder (Optional) -->
        <div class="p-3 rounded-4 mb-4 bg-light text-dark border shadow-inner" style="background: rgba(0,0,0,0.02) !important;">
            <small class="text-primary fw-bold d-block mb-1">WHAT'S NEXT?</small>
            <span class="small">Apne orders page par jaakar delivery tracking aur OTP check kar sakte ho.</span>
        </div>

        <!-- Responsive Action Buttons -->
        <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
            <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-primary btn-lg rounded-pill fw-bold px-4 shadow">
                <i class="fa-solid fa-truck-fast me-2"></i> My Orders
            </a>
            
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-lg rounded-pill fw-bold px-4">
                <i class="fa-solid fa-house me-2"></i> Home
            </a>
        </div>

        <!-- Tagline -->
        <div class="mt-5 pt-3 border-top opacity-50">
            <small class="fw-bold text-uppercase" style="letter-spacing: 2px; font-size: 10px;">SwapKart Marketplace</small>
        </div>

    </div>

</div>

<style>
    .fw-800 { font-weight: 800; }
    
    /* Animation adjustment */
    .animate__animated { --animate-duration: 0.8s; }

    /* Custom success circle look */
    .success-icon-circle {
        width: 100px;
        height: 100px;
        background: rgba(34, 197, 94, 0.1);
        border-radius: 50%;
    }

    /* Standard Button fix for Dark/Light compatibility */
    .btn-lg {
        font-size: 1rem;
        padding: 12px 24px;
    }

    /* Mobile specific tweaks */
    @media (max-width: 576px) {
        .min-vh-100 { min-height: 85vh !important; }
        .sk-card { border-radius: 24px !important; margin: 0 10px; }
        .p-4 { padding: 30px 20px !important; }
        .btn-lg { width: 100%; }
    }

    /* Dark Mode internal element visibility */
    .dark-theme .bg-light { 
        background: rgba(255, 255, 255, 0.05) !important; 
        color: white !important; 
        border: 1px solid rgba(255,255,255,0.1) !important; 
    }
    .dark-theme .text-dark { color: #f8fafc !important; }
</style>

</body>
</html>