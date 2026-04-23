<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 1. Mobile Friendly Viewport -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Browser Tab Icon -->
<link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/599/599305.png">

<!-- Assets -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
    /* --- THEME COLORS --- */
    :root {
        --bg-main: #f8fafc; --nav-bg: #0f172a; --card-bg: #ffffff;
        --text-main: #1e293b; --text-muted: #64748b; --border: rgba(0, 0, 0, 0.1);
        --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
    }

    .dark-theme {
        --bg-main: #0f172a; --nav-bg: #020617; --card-bg: rgba(255, 255, 255, 0.08);
        --text-main: #f8fafc !important; --text-muted: #94a3b8 !important; --border: rgba(255, 255, 255, 0.1);
    }

    body {
        background-color: var(--bg-main) !important;
        color: var(--text-main) !important;
        font-family: 'Plus Jakarta Sans', sans-serif;
        transition: 0.3s ease;
        overflow-x: hidden;
    }
    
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
        margin: 0 4px; text-decoration: none; transition: 0.3s;
        display: flex; align-items: center; gap: 8px;
    }
    .nav-link-custom:hover { color: #fff !important; transform: translateY(-1px); }

    .theme-toggle-btn {
        background: rgba(255, 255, 255, 0.1);
        color: white !important; padding: 7px 15px; border-radius: 50px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        font-size: 13px; font-weight: 600; transition: 0.3s;
    }
    .theme-toggle-btn:hover { background: rgba(255, 255, 255, 0.2); }

    .wallet-badge {
        background: rgba(16, 185, 129, 0.15);
        color: #10b981; padding: 7px 16px; border-radius: 50px;
        font-weight: 700; font-size: 13px; border: 1px solid rgba(16, 185, 129, 0.3);
        display: flex; align-items: center; gap: 6px;
    }

    .btn-sell-nav {
        background: var(--primary-gradient);
        color: white !important; padding: 9px 24px;
        border-radius: 12px; font-weight: 700; border: none;
        box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3); font-size: 14px;
    }

    /* --- PROPER SPACING FOR COLLAPSE MENU --- */
    @media (max-width: 991px) {
        .navbar-collapse {
            background: var(--nav-bg);
            padding: 25px; border-radius: 24px;
            margin-top: 15px; border: 1px solid var(--border);
            box-shadow: 0 15px 40px rgba(0,0,0,0.4);
        }
        .nav-item { width: 100%; margin: 8px 0; }
        .ms-auto-custom { 
            flex-direction: column !important; 
            align-items: flex-start !important; 
            gap: 20px !important; 
            width: 100%;
        }
        .dropdown, .wallet-badge, .btn-sell-nav, .theme-toggle-btn { width: 100%; }
        .btn-sell-nav { text-align: center; }
        .nav-link-custom { padding: 12px 0; border-bottom: 1px solid rgba(255,255,255,0.05); }
    }

    .dropdown-menu {
        border-radius: 18px; border: 1px solid var(--border);
        box-shadow: 0 15px 35px rgba(0,0,0,0.2); padding: 10px;
        background: var(--card-bg) !important;
    }
    .dropdown-item { border-radius: 10px; padding: 10px 15px; font-weight: 600; color: var(--text-main) !important; }
    .dropdown-item:hover { background: rgba(99, 102, 241, 0.1); color: #6366f1 !important; }

    .sk-card { background: var(--card-bg) !important; border: 1px solid var(--border) !important; border-radius: 24px !important; color: var(--text-main) !important; }
</style>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
            <i class="fa-solid fa-bolt-lightning me-2 text-warning"></i> SwapKart
        </a>

        <!-- Mobile Toggler -->
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
            <i class="fa-solid fa-bars-staggered text-white fs-3"></i>
        </button>

        <div class="collapse navbar-collapse" id="navContent">
            <!-- Left Side Links -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link-custom" href="${pageContext.request.contextPath}/"><i class="fa-solid fa-house"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="${pageContext.request.contextPath}/products"><i class="fa-solid fa-compass"></i> Explore</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="${pageContext.request.contextPath}/wishlist"><i class="fa-solid fa-heart"></i> Wishlist</a></li>
            </ul>

            <!-- Right Side (Using Flex Gap for Proper Spacing) -->
            <div class="d-flex align-items-center ms-auto ms-auto-custom" style="gap: 12px;">
                
                

                <!-- Theme Toggle -->
                <a href="${pageContext.request.contextPath}/toggleTheme" class="theme-toggle-btn text-decoration-none">
                    <c:choose>
                        <c:when test="${sessionScope.theme == 'dark'}"><i class="fa-solid fa-sun text-warning me-1"></i> Light</c:when>
                        <c:otherwise><i class="fa-solid fa-moon text-info me-1"></i> Dark</c:otherwise>
                    </c:choose>
                </a>

                <c:choose>
                    <c:when test="${not empty user}">
                        <!-- Wallet -->
                        <div class="wallet-badge">
                            <i class="fa-solid fa-wallet"></i> ${user.walletBalance}
                        </div>

                        <!-- Cart -->
                        <a href="${pageContext.request.contextPath}/cart" class="nav-link-custom">
                            <i class="fa-solid fa-cart-shopping fa-lg"></i> <span class="d-lg-none">My Cart</span>
                        </a>

                        <!-- Sell -->
                        <a href="${pageContext.request.contextPath}/sell" class="btn btn-sell-nav">Sell Now</a>

                        <!-- User Profile -->
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle text-white text-decoration-none fw-bold d-flex align-items-center" data-bs-toggle="dropdown">
                                <img src="https://ui-avatars.com/api/?name=${user.fullName}&background=6366f1&color=fff" class="rounded-circle me-2" width="30">
                                ${user.fullName.split(' ')[0]}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow-lg mt-lg-3">
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
                        <div class="d-flex align-items-center" style="gap: 15px;">
                            <a href="${pageContext.request.contextPath}/login" class="nav-link-custom">Login</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-sell-nav">Join Now</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>