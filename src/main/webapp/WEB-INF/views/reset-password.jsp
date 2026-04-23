<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- 1. Mobile Meta Tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<div class="container d-flex align-items-center justify-content-center min-vh-100 py-5">
    
    <div class="sk-card p-4 p-md-5 shadow-lg animate__animated animate__zoomIn border-0" style="max-width: 450px; width: 100%;">
        
        <!-- Icon Section -->
        <div class="text-center mb-4">
            <div class="mx-auto d-flex align-items-center justify-content-center shadow-sm" 
                 style="width: 80px; height: 80px; background: rgba(34, 197, 94, 0.1); border-radius: 20px;">
                <i class="fa-solid fa-key fa-2x text-success"></i>
            </div>
        </div>

        <div class="text-center mb-4">
            <h2 class="fw-800 mb-2">Set New Password</h2>
            <p class="text-muted small">Bhai, naya aur mazboot password set karlo taki account safe rahe.</p>
        </div>

        <!-- Local Error Box -->
        <div id="validError" class="alert alert-danger d-none small p-2 text-center mb-3 rounded-3"></div>

        <form action="${pageContext.request.contextPath}/resetPassword" method="post" id="resetForm">
            <!-- Hidden Token -->
            <input type="hidden" name="token" value="${token}">
            
            <!-- Password Input -->
            <div class="mb-3">
                <label class="form-label small fw-bold text-muted">New Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0">
                        <i class="fa-solid fa-lock text-primary"></i>
                    </span>
                    <input type="password" name="password" id="pass1" class="form-control border-start-0 py-2" 
                           placeholder="At least 6 characters" required>
                </div>
            </div>

            <!-- Confirm Password Input -->
            <div class="mb-4">
                <label class="form-label small fw-bold text-muted">Confirm Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0">
                        <i class="fa-solid fa-shield-check text-primary"></i>
                    </span>
                    <input type="password" id="pass2" class="form-control border-start-0 py-2" 
                           placeholder="Re-type password" required>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-success btn-lg w-100 rounded-pill fw-bold py-3 shadow mb-3">
                Update Password <i class="fa-solid fa-check-circle ms-2"></i>
            </button>

            <!-- Back Link -->
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none small fw-bold text-muted">
                    Cancel & Wapas Jao
                </a>
            </div>

        </form>

        <!-- Branding -->
        <div class="mt-5 pt-3 border-top text-center opacity-50">
            <small class="fw-bold text-uppercase" style="letter-spacing: 1px; font-size: 10px;">SwapKart Security Layer</small>
        </div>

    </div>

</div>

<!-- JS Validation -->
<script>
    document.getElementById("resetForm").onsubmit = function(e) {
        const p1 = document.getElementById("pass1").value;
        const p2 = document.getElementById("pass2").value;
        const errorBox = document.getElementById("validError");

        if (p1.length < 6) {
            errorBox.innerText = "Bhai, password kam se kam 6 akshar ka rakho!";
            errorBox.classList.remove("d-none");
            e.preventDefault();
            return false;
        }

        if (p1 !== p2) {
            errorBox.innerText = "Dono password match nahi kar rahe!";
            errorBox.classList.remove("d-none");
            e.preventDefault();
            return false;
        }
        return true;
    };
</script>

<style>
    .fw-800 { font-weight: 800; }
    .form-control:focus { border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1); }
    .input-group-text { color: #6366f1; border-color: #dee2e6; }
    
    /* Dark Mode input override */
    .dark-theme .input-group-text { border-color: rgba(255,255,255,0.1); }

    @media (max-width: 576px) {
        .sk-card { border-radius: 20px !important; margin: 0 15px; }
        .p-4 { padding: 30px 20px !important; }
    }
</style>

</body>
</html>