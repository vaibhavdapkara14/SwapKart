<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 1. Browser Tab Icon (Favicon) - Pro Bolt Icon -->
<link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/599/599305.png">

<!-- 2. External Assets -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
    /* --- THEME COLORS --- */
    :root {
        --bg-main: #f8fafc;
        --nav-bg: #0f172a; 
        --card-bg: #ffffff;
        --text-main: #1e293b;
        --text-muted: #64748b;
        --border: rgba(0, 0, 0, 0.1);
        --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
    }

    .dark-theme {
        --bg-main: #0f172a;
        --nav-bg: #020617;
        --card-bg: rgba(255, 255, 255, 0.08);
        --text-main: #f8fafc !important;
        --text-muted: #94a3b8 !important;
        --border: rgba(255, 255, 255, 0.1);
    }

    /* GLOBAL FIXES */
    body {
        background-color: var(--bg-main) !important;
        color: var(--text-main) !important;
        font-family: 'Plus Jakarta Sans', sans-serif;
        transition: 0.3s ease;
    }
    
    /* Dark Mode Font Color Force Fix */
    .dark-theme h1, .dark-theme h2, .dark-theme h3, .dark-theme h4, .dark-theme h5, .dark-theme p, 
    .dark-theme span, .dark-theme label, .dark-theme .form-label, .dark-theme td, .dark-theme th { 
        color: var(--text-main) !important; 
    }

    .navbar-custom {
        background: var(--nav-bg) !important;
        backdrop-filter: blur(15px);
        border-bottom: 1px solid var(--border);
        padding: 12px 0;
        z-index: 1050;
    }

    .navbar-brand {
        font-weight: 800; font-size: 24px;
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        letter-spacing: -0.5px;
    }

    .nav-link-custom {
        color: rgba(255, 255, 255, 0.8) !important;
        font-weight: 600; font-size: 14px;
        margin: 0 10px; text-decoration: none; transition: 0.3s;
    }
    .nav-link-custom:hover { color: #fff !important; transform: translateY(-2px); }

    .theme-toggle-btn {
        background: rgba(255, 255, 255, 0.1);
        color: white !important;
        padding: 6px 14px; border-radius: 50px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        font-size: 13px; font-weight: 600;
        transition: 0.3s;
    }
    .theme-toggle-btn:hover { background: rgba(255, 255, 255, 0.2); }

    .wallet-badge {
        background: rgba(16, 185, 129, 0.15);
        color: #10b981; padding: 6px 15px; border-radius: 50px;
        font-weight: 700; font-size: 13px; margin-right: 12px;
        border: 1px solid rgba(16, 185, 129, 0.3);
    }

    .btn-sell-nav {
        background: var(--primary-gradient);
        color: white !important; padding: 8px 20px;
        border-radius: 12px; font-weight: 700; border: none;
        box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3); font-size: 14px;
    }

    /* DROPDOWN */
    .dropdown-menu {
        border-radius: 18px; border: 1px solid var(--border);
        box-shadow: 0 15px 35px rgba(0,0,0,0.2); padding: 10px;
        background: var(--card-bg) !important;
    }
    .dropdown-item {
        border-radius: 10px; padding: 10px 15px; font-weight: 600;
        color: var(--text-main) !important;
    }
    .dropdown-item:hover { background: rgba(99, 102, 241, 0.1); color: #6366f1 !important; }

    /* CARD STYLE GLOBAL */
    .sk-card {
        background: var(--card-bg) !important;
        border: 1px solid var(--border) !important;
        border-radius: 24px !important;
        color: var(--text-main) !important;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top animate__animated animate__fadeInDown">
    <div class="container">
        <!-- Home Link Logo -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fa-solid fa-bolt-lightning me-1 text-warning"></i> SwapKart
        </a>

        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
            <i class="fa-solid fa-bars"></i>
        </button>

        <div class="collapse navbar-collapse" id="navContent">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link-custom" href="${pageContext.request.contextPath}/"><i class="fa-solid fa-house me-1"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="${pageContext.request.contextPath}/products"><i class="fa-solid fa-compass me-1"></i> Explore</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="${pageContext.request.contextPath}/wishlist"><i class="fa-solid fa-heart me-1"></i> Wishlist</a></li>
            </ul>

            <div class="d-flex align-items-center">
                <!-- 1. LANGUAGE SELECTOR -->
                <div class="dropdown me-3">
                    <button class="theme-toggle-btn dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-language"></i>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="?lang=en">English</a></li>
                        <li><a class="dropdown-item" href="?lang=hi">हिन्दी</a></li>
                    </ul>
                </div>

                <!-- 2. THEME TOGGLE BUTTON -->
                <a href="${pageContext.request.contextPath}/toggleTheme" class="theme-toggle-btn text-decoration-none me-3">
                    <c:choose>
                        <c:when test="${sessionScope.theme == 'dark'}"> Light</c:when>
                        <c:otherwise> Dark</c:otherwise>
                    </c:choose>
                </a>

                <c:choose>
                    <c:when test="${not empty user}">
                        <!-- 3. WALLET WITH SYMBOL -->
                        <div class="wallet-badge d-none d-md-flex align-items-center">
                            <i class="fa-solid fa-wallet me-2"></i>  ${user.walletBalance}
                        </div>

                        <!-- 4. CART -->
                        <a href="${pageContext.request.contextPath}/cart" class="nav-link-custom me-3">
                            <i class="fa-solid fa-cart-shopping fa-lg"></i>
                        </a>

                        <!-- 5. SELL BUTTON -->
                        <a href="${pageContext.request.contextPath}/sell" class="btn btn-sell-nav me-3">Sell Now</a>

                        <!-- 6. USER PROFILE DROPDOWN -->
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle text-white text-decoration-none fw-bold" data-bs-toggle="dropdown">
                                <c:out value="${user.fullName.split(' ')[0]}" />
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow-lg mt-3">
                                <c:if test="${user.role == 'ADMIN'}">
                                    <li><a class="dropdown-item fw-bold text-primary" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-gauge-high me-2"></i> Admin Panel</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                
                                <c:if test="${user.role == 'DRIVER'}">
                                    <li><a class="dropdown-item fw-bold text-success" href="${pageContext.request.contextPath}/driver/dashboard"><i class="fa-solid fa-truck me-2"></i> Driver Panel</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>

                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-id-card me-2"></i> My Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-ads"><i class="fa-solid fa-box-open me-2"></i> My Listings</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-orders"><i class="fa-solid fa-truck-fast me-2"></i> My Orders</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-power-off me-2"></i> Logout</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="nav-link-custom">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-sell-nav ms-2">Join Now</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>