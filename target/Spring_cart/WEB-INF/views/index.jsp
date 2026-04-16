<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
    <title>SwapKart</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --primary: #002f34;
            --accent: #00a49f;
            --bg-dark: #0b0f1a;
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            background: #f8fafc;
            color: #1e293b;
            margin: 0;
        }

        body.dark-theme { background: var(--bg-dark); color: #f1f5f9; }

        /* --- FULLSCREEN HERO SECTION --- */
        .hero-fullscreen {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            background: radial-gradient(circle at top right, rgba(0, 164, 159, 0.15), transparent),
                        radial-gradient(circle at bottom left, rgba(0, 47, 52, 0.1), transparent);
            position: relative;
        }

        .main-title {
            font-size: clamp(3rem, 10vw, 6rem);
            font-weight: 800;
            letter-spacing: -3px;
            margin-bottom: 20px;
            color: var(--primary); /* Animation hatane ke baad simple solid color */
        }

        .dark-theme .main-title {
            color: #ffffff;
        }

        .hero-desc {
            font-size: 1.4rem;
            max-width: 700px;
            opacity: 0.7;
            margin-bottom: 40px;
        }

        /* Fixed Scroll Indicator (No Bounce) */
        .scroll-indicator {
            position: absolute;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
        }

        /* --- CONTENT SECTION --- */
        .content-section {
            padding: 100px 0;
            background: white;
            border-top-left-radius: 60px;
            border-top-right-radius: 60px;
            box-shadow: 0 -20px 50px rgba(0,0,0,0.05);
        }

        .dark-theme .content-section {
            background: #111827;
            box-shadow: 0 -20px 50px rgba(0,0,0,0.4);
        }

        /* Card Styling (Keeping hover effect but no entry animation) */
        .sk-card {
            background: #f8fafc;
            border-radius: 30px;
            padding: 40px 30px;
            transition: transform 0.2s ease, background 0.2s ease;
            border: 1px solid rgba(0,0,0,0.03);
            text-decoration: none !important;
            display: block;
            text-align: center;
        }

        .dark-theme .sk-card { background: #1f2937; border-color: #222; }

        .sk-card:hover {
            transform: translateY(-10px);
            background: var(--accent);
            box-shadow: 0 20px 40px rgba(0, 164, 159, 0.2);
        }

        .sk-card:hover h3, .sk-card:hover p, .sk-card:hover i { color: #111 !important; }

        .icon-circle {
            width: 70px; height: 70px;
            background: white;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            font-size: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .dark-theme .icon-circle { background: #111827; }

    </style>
</head>

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<jsp:include page="header.jsp" />

<div class="hero-fullscreen">
    <div>
        <h1 class="main-title">Welcome to SwapKart 👋</h1>
        <p class="hero-desc">Experience the future of trading. Buy, Sell, and Swap with confidence on India's most trusted marketplace.</p>
        <div class="d-flex gap-3 justify-content-center">
            <a href="#options" class="btn btn-dark btn-lg rounded-pill px-5 py-3 fw-bold">Get Started</a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark btn-lg rounded-pill px-5 py-3 fw-bold">Browse Items</a>
        </div>
    </div>

    <div class="scroll-indicator text-muted">
        <p class="small mb-1">Scroll Down</p>
        <i class="fa-solid fa-chevron-down"></i>
    </div>
</div>

<div id="options" class="content-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-800 display-6">What would you like to do?</h2>
            <p class="text-muted">Choose an option below to begin your journey</p>
        </div>

        <div class="row g-4 justify-content-center">
            <div class="col-lg-3 col-md-6">
                <a href="${pageContext.request.contextPath}/products" class="sk-card shadow-sm">
                    <div class="icon-circle text-primary"><i class="fa-solid fa-magnifying-glass"></i></div>
                    <h3 class="fw-bold h4 text-dark">Explore</h3>
                    <p class="text-muted small">Premium pre-owned items at half the price.</p>
                </a>
            </div>

            <div class="col-lg-3 col-md-6">
                <a href="${pageContext.request.contextPath}/sell" class="sk-card shadow-sm">
                    <div class="icon-circle text-success"><i class="fa-solid fa-plus"></i></div>
                    <h3 class="fw-bold h4 text-dark">Sell Item</h3>
                    <p class="text-muted small">Turn your unused stuff into instant cash.</p>
                </a>
            </div>

            <div class="col-lg-3 col-md-6">
                <a href="${pageContext.request.contextPath}/profile" class="sk-card shadow-sm">
                    <div class="icon-circle text-warning"><i class="fa-solid fa-user"></i></div>
                    <h3 class="fw-bold h4 text-dark">My Account</h3>
                    <p class="text-muted small">Track your balance and manage settings.</p>
                </a>
            </div>

            <div class="col-lg-3 col-md-6">
                <a href="${pageContext.request.contextPath}/my-orders" class="sk-card shadow-sm">
                    <div class="icon-circle text-info"><i class="fa-solid fa-truck"></i></div>
                    <h3 class="fw-bold h4 text-dark">Orders</h3>
                    <p class="text-muted small">Real-time tracking of your purchases.</p>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if(target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
</script>

</body>
</html>