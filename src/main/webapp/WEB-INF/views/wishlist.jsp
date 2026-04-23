<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- 1. Mobile Meta Tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-4 py-md-5">
    
    <div class="row mb-4 animate__animated animate__fadeInDown">
        <div class="col-12">
            <h2 class="fw-800"><i class="fa-solid fa-heart text-danger me-2"></i> My Wishlist</h2>
            <p class="text-muted small">Items you've saved to buy later.</p>
        </div>
    </div>

    <!-- Empty Wishlist Section -->
    <c:if test="${empty list}">
        <div class="sk-card p-5 text-center shadow-sm border-0 animate__animated animate__zoomIn">
            <i class="fa-regular fa-heart fa-4x text-muted mb-3 opacity-25"></i>
            <h4 class="text-muted">Your wishlist is Empty !</h4>
            <p class="small text-muted mb-4">Marketplace explore karo aur pasandida cheezein yahan save karo.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-5 fw-bold shadow">
                Explore Market
            </a>
        </div>
    </c:if>

    <div class="row g-3">
        <c:forEach var="p" items="${list}">
            <div class="col-12">
                <!-- wishlist-item responsive logic -->
                <div class="sk-card p-3 p-md-4 shadow-sm border-0 animate__animated animate__fadeInUp">
                    <div class="row align-items-center">
                        
                        <!-- 1. Product Image (Responsive) -->
                        <div class="col-12 col-md-2 text-center mb-3 mb-md-0">
                            <!-- CLOUDINARY FIX: Direct URL used here -->
                            <img src="${p.image}" 
                                 onerror="this.src='https://placehold.co/400x300?text=SwapKart'"
                                 class="rounded-4 border shadow-sm" 
                                 style="width: 100px; height: 100px; object-fit: cover;">
                        </div>

                        <!-- 2. Product Details -->
                        <div class="col-12 col-md-6 text-center text-md-start">
                            <h5 class="fw-bold mb-1 text-main">${p.title}</h5>
                            <span class="badge bg-light text-dark border mb-2" style="font-size: 10px;">${p.category}</span>
                            <h4 class="text-success fw-800 mb-0">₹ ${p.price}</h4>
                        </div>

                        <!-- 3. Actions Button (Responsive stack) -->
                        <div class="col-12 col-md-4 mt-3 mt-md-0">
                            <div class="d-flex flex-column flex-sm-row gap-2 justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/product/details?id=${p.id}" 
                                   class="btn btn-primary rounded-pill fw-bold px-4">
                                    <i class="fa-solid fa-eye me-1"></i> View
                                </a>
                                <a href="${pageContext.request.contextPath}/removeFromWishlist?id=${p.id}" 
                                   class="btn btn-outline-danger rounded-pill fw-bold px-4" 
                                   onclick="return confirm('Are you sure?')">
                                    <i class="fa-solid fa-trash-can me-1"></i> Remove
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<style>
    .fw-800 { font-weight: 800; }
    
    /* Input/Button sizing for better touch targets on mobile */
    .btn {
        padding: 10px 20px;
        font-size: 14px;
    }

    /* Transition effect for the card */
    .sk-card {
        transition: transform 0.3s ease;
    }
    .sk-card:hover {
        transform: translateY(-5px);
    }

    /* Mobile view specific adjustments */
    @media (max-width: 767px) {
        .container { padding-left: 15px; padding-right: 15px; }
        .sk-card { text-align: center; border-radius: 20px !important; }
        .btn { width: 100%; } /* Mobile par buttons full width */
        img { width: 120px !important; height: 120px !important; }
    }

    /* Dark Mode specific background override for light boxes */
    .dark-theme .bg-light { 
        background: rgba(255, 255, 255, 0.05) !important; 
        color: white !important; 
        border: 1px solid rgba(255,255,255,0.1) !important; 
    }
</style>
</body>
</html>