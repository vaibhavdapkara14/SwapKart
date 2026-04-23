<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- 1. Mobile Meta Tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container d-flex align-items-center justify-content-center min-vh-100 py-5">
    
    <div class="sk-card p-4 p-md-5 text-center shadow-lg animate__animated animate__zoomIn border-0" style="max-width: 550px;">
        
        <!-- Error Icon -->
        <div class="mb-4">
            <i class="fa-solid fa-circle-exclamation fa-5x text-danger animate__animated animate__shakeX animate__infinite animate__slow"></i>
        </div>

        <!-- Heading -->
        <h1 class="fw-800 mb-3" style="font-size: clamp(1.8rem, 5vw, 2.5rem);">Oops! System Error</h1>
        
        <!-- Message -->
        <p class="text-muted mb-4 px-2" style="font-size: 16px; line-height: 1.6;">
            Bhai, lagta hai piche kuch fat gaya hai. Product save nahi ho paya. Ek baar phir se koshish karo ya console logs check karo.
        </p>

        <!-- Responsive Buttons -->
        <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center">
            <a href="${pageContext.request.contextPath}/sell" class="btn btn-primary btn-lg rounded-pill fw-bold px-4 shadow">
                <i class="fa-solid fa-rotate-left me-2"></i> Try Again
            </a>
            
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-lg rounded-pill fw-bold px-4">
                <i class="fa-solid fa-house me-2"></i> Go Home
            </a>
        </div>

        <!-- Support Info -->
        <div class="mt-5 pt-4 border-top opacity-50">
            <small class="fw-bold text-uppercase" style="letter-spacing: 1px;">SwapKart Developer Console</small>
        </div>

    </div>

</div>

<style>
    .fw-800 { font-weight: 800; }
    
    /* Error page specific button adjustment */
    .btn-lg {
        font-size: 1rem;
        padding: 12px 25px;
    }

    /* Mobile specific tweaks */
    @media (max-width: 576px) {
        .min-vh-100 { min-height: 80vh !important; }
        .p-4 { padding: 30px 20px !important; }
    }
</style>
</body>
</html>