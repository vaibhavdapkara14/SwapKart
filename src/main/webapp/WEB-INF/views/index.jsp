<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- ZAROORI: Mobile responsiveness ke liye meta tag -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
    <title>SwapKart | Modern Marketplace</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --primary: #002f34;
            --accent: #00a49f;
            --bg-dark: #0f172a;
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            background: #f8fafc;
            color: #1e293b;
            margin: 0;
            overflow-x: hidden; /* Horizontal scroll block karne ke liye */
        }

        body.dark-theme { background: var(--bg-dark); color: #f1f5f9; }

        /* --- RESPONSIVE HERO SECTION --- */
        .hero-fullscreen {
            min-height: 100vh; /* height badal kar min-height kiya mobile ke liye */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 80px 20px; /* Mobile par padding zaroori hai */
            background: radial-gradient(circle at top right, rgba(0, 164, 159, 0.15), transparent),
                        radial-gradient(circle at bottom left, rgba(0, 47, 52, 0.1), transparent);
            position: relative;
        }

        .main-title {
            /* Responsive Font Size */
            font-size: clamp(2.5rem, 8vw, 5.5rem);
            font-weight: 800;
            letter-spacing: -2px;
            margin-bottom: 20px;
            color: var(--primary);
            line-height: 1.1;
        }

        .dark-theme .main-title { color: #ffffff; }

        .hero-desc {
            font-size: clamp(1rem, 4vw, 1.3rem);
            max-width: 800px;
            opacity: 0.7;
            margin-bottom: 40px;
            padding: 0 10px;
        }

        /* --- RESPONSIVE CONTENT SECTION --- */
        .content-section {
            padding: 60px 0; /* Padding kam ki mobile ke liye */
            background: white;
            border-top-left-radius: 40px; /* Radius thoda kam kiya mobile ke liye */
            border-top-right-radius: 40px;
            box-shadow: 0 -20px 50px rgba(0,0,0,0.05);
            margin-top: -40px; /* Smooth overlap */
        }

        @media (min-width: 768px) {
            .content-section { padding: 100px 0; border-top-left-radius: 60px; border-top-right-radius: 60px; }
        }

        .dark-theme .content-section { background: #111827; }

        /* --- RESPONSIVE CARDS --- */
        .sk-card {
            background: #f8fafc;
            border-radius: 25px;
            padding: 30px 20px;
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
            text-decoration: none !important;
            display: flex;
            flex-direction: column;
            height: 100%;
            text-align: center;
        }

        .dark-theme .sk-card { background: #1f2937; border-color: #374151; }

        .sk-card:hover {
            transform: translateY(-10px);
            background: var(--accent);
            box-shadow: 0 20px 40px rgba(0, 164, 159, 0.2);
        }

        .sk-card:hover h3, .sk-card:hover p, .sk-card:hover i { color: #000 !important; }

        .icon-circle {
            width: 60px; height: 60px;
            background: white;
            border-radius: 18px; /* Square with round corners look modern */
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            font-size: 1.4rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .dark-theme .icon-circle { background: #111827; }

        /* Fixed Scroll Indicator */
        .scroll-indicator {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: none; /* Desktop par hi dikhayenge */
        }
        @media (min-width: 768px) { .scroll-indicator { display: block; } }
    </style>
</head>

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<jsp:include page="header.jsp" />

<!-- Hero Section -->
<div class="hero-fullscreen">
    <div class="container animate__animated animate__fadeIn">
        <h1 class="main-title">Welcome to SwapKart 👋</h1>
        <p class="hero-desc">Experience the future of trading. Buy, Sell, and Swap with confidence on India's most trusted marketplace.</p>
        
        <!-- Button Group Responsive -->
        <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center px-4">
            <a href="#options" class="btn btn-dark btn-lg rounded-pill px-5 py-3 fw-bold shadow-lg">Get Started</a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark btn-lg rounded-pill px-5 py-3 fw-bold">Browse Items</a>
        </div>
    </div>

    <div class="scroll-indicator text-muted">
        <p class="small mb-1">Scroll Down</p>
        <i class="fa-solid fa-chevron-down"></i>
    </div>
</div>

<!-- Options Grid -->
<div id="options" class="content-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-800 display-6 px-3">What would you like to do?</h2>
            <p class="text-muted">Choose an option below to begin your journey</p>
        </div>

        <div class="row g-3 g-md-4">
            <!-- Explore Card -->
            <div class="col-12 col-sm-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/products" class="sk-card shadow-sm">
                    <div class="icon-circle text-primary"><i class="fa-solid fa-magnifying-glass"></i></div>
                    <h3 class="fw-bold h5 text-dark mb-2">Explore</h3>
                    <p class="text-muted small mb-0">Premium pre-owned items at half the price.</p>
                </a>
            </div>

            <!-- Sell Card -->
            <div class="col-12 col-sm-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/sell" class="sk-card shadow-sm">
                    <div class="icon-circle text-success"><i class="fa-solid fa-plus"></i></div>
                    <h3 class="fw-bold h5 text-dark mb-2">Sell Item</h3>
                    <p class="text-muted small mb-0">Turn your unused stuff into instant cash.</p>
                </a>
            </div>

            <!-- Account Card -->
            <div class="col-12 col-sm-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/profile" class="sk-card shadow-sm">
                    <div class="icon-circle text-warning"><i class="fa-solid fa-user"></i></div>
                    <h3 class="fw-bold h5 text-dark mb-2">My Account</h3>
                    <p class="text-muted small mb-0">Track your balance and manage settings.</p>
                </a>
            </div>

            <!-- Orders Card -->
            <div class="col-12 col-sm-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/my-orders" class="sk-card shadow-sm">
                    <div class="icon-circle text-info"><i class="fa-solid fa-truck"></i></div>
                    <h3 class="fw-bold h5 text-dark mb-2">Orders</h3>
                    <p class="text-muted small mb-0">Real-time tracking of your purchases.</p>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Smooth Scroll Logic
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if(target) {
                const headerOffset = 70;
                const elementPosition = target.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                window.scrollTo({
                    top: offsetPosition,
                    behavior: "smooth"
                });
            }
        });
    });
</script>

</body>
</html>