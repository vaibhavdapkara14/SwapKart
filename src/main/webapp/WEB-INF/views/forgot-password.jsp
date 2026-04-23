<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<div class="container d-flex align-items-center justify-content-center min-vh-100 py-5">
    
    <div class="sk-card p-4 p-md-5 shadow-lg animate__animated animate__zoomIn border-0" style="max-width: 450px; width: 100%;">
        
        <!-- Icon Section -->
        <div class="text-center mb-4">
            <div class="mx-auto d-flex align-items-center justify-content-center shadow-sm" 
                 style="width: 80px; height: 80px; background: rgba(99, 102, 241, 0.1); border-radius: 20px;">
                <i class="fa-solid fa-lock-open fa-2x text-primary"></i>
            </div>
        </div>

        <div class="text-center mb-4">
            <h2 class="fw-800 mb-2">Forgot Password?</h2>
            <p class="text-muted small px-3">Bhai, apna registered email dalo. Hum tumhare inbox mein ek reset link bhej denge.</p>
        </div>

        <!-- Error/Success Messages from Controller -->
        <c:if test="${not empty param.msg}">
            <div class="alert alert-info border-0 rounded-4 small py-2 text-center mb-4">
                <i class="fa-solid fa-circle-info me-1"></i> ${param.msg}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgotPassword" method="post">
            
            <!-- Email Input -->
            <div class="mb-4">
                <label class="form-label small fw-bold text-muted">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0">
                        <i class="fa-regular fa-envelope text-primary"></i>
                    </span>
                    <input type="email" name="email" class="form-control border-start-0 py-2" 
                           placeholder="name@example.com" required>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold py-3 shadow mb-3">
                Send Reset Link <i class="fa-solid fa-paper-plane ms-2"></i>
            </button>

            <!-- Back to Login -->
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none small fw-bold">
                    <i class="fa-solid fa-arrow-left me-1"></i> Login again !
                </a>
            </div>

        </form>

        <!-- Technical Support -->
        <div class="mt-5 pt-3 border-top text-center opacity-50">
            <small class="fw-bold text-uppercase" style="letter-spacing: 1px; font-size: 10px;">SwapKart Security</small>
        </div>

    </div>

</div>

<style>
    .fw-800 { font-weight: 800; }
    
    /* Input focus colors matching primary theme */
    .form-control:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
    }
    
    .input-group-text {
        color: #6366f1;
    }

    /* Small Screen Adjustments */
    @media (max-width: 576px) {
        .sk-card { border-radius: 20px !important; margin: 0 15px; }
        .p-4 { padding: 30px 20px !important; }
    }
</style>

</body>
</html>