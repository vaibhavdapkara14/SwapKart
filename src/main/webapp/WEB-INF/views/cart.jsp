<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- 1. Mobile Meta Tag (Zaroori) -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-4 py-md-5">
    <!-- Header Responsive -->
    <div class="d-flex align-items-center mb-4 px-2">
        <i class="fa-solid fa-cart-shopping fa-2x text-primary me-3"></i>
        <h2 class="fw-800 mb-0" style="font-size: clamp(1.5rem, 5vw, 2rem);">My Shopping Cart</h2>
    </div>
    
    <div class="row justify-content-center">
        <div class="col-12 col-lg-9">
            <c:forEach var="item" items="${cartList}">
                <!-- sk-card responsive flex: mobile par column, desktop par row -->
                <div class="sk-card p-3 mb-3 d-flex flex-column flex-sm-row align-items-center justify-content-between shadow-sm border-0 animate__animated animate__fadeIn">
                    
                    <div class="d-flex align-items-center w-100 mb-3 mb-sm-0">
                        <!-- Image Responsive size -->
                        <img src="${item.product.image}" 
                             onerror="this.src='https://placehold.co/300x200?text=No+Image'" 
                             width="80" height="70" 
                             style="object-fit: cover; min-width: 80px;" 
                             class="rounded-3 me-3 border">
                        
                        <div class="overflow-hidden">
                            <h6 class="mb-1 fw-bold text-main text-truncate" style="max-width: 100%;">${item.product.title}</h6>
                            <span class="text-success fw-800 fs-5">₹ ${item.product.price}</span>
                        </div>
                    </div>

                    <!-- Remove Button: Mobile par full width -->
                    <div class="w-100 w-sm-auto text-end">
                        <a href="${pageContext.request.contextPath}/removeFromCart?id=${item.cartId}" 
                           class="btn btn-sm btn-outline-danger border-0 rounded-pill px-3 py-2 w-100 w-sm-auto">
                            <i class="fa-solid fa-trash-can me-1"></i> <span class="d-sm-none">Remove Item</span>
                        </a>
                    </div>
                </div>
            </c:forEach>

            <!-- Empty Cart Section -->
            <c:if test="${empty cartList}">
                <div class="sk-card p-5 text-center shadow-sm border-0">
                    <i class="fa-solid fa-basket-shopping fa-4x text-muted mb-3 opacity-25"></i>
                    <h4 class="text-muted">Your cart is Empty !</h4>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-5 mt-3 fw-bold shadow">
                        Explore Marketplace
                    </a>
                </div>
            </c:if>

            <!-- Total Section Responsive -->
            <c:if test="${not empty cartList}">
                <div class="sk-card p-4 text-center mt-4 border-0 shadow-lg" 
                     style="background: var(--card-bg); border: 2px solid #6366f1 !important;">
                    <p class="mb-1 opacity-75 small fw-bold">TOTAL PAYABLE AMOUNT</p>
                    <h1 class="fw-800 mb-4 text-primary" style="font-size: clamp(2rem, 8vw, 3rem);">₹ ${totalPrice}</h1>
                    
                    <a href="${pageContext.request.contextPath}/checkout" 
                       class="btn btn-primary btn-lg w-100 rounded-pill fw-bold py-3 shadow-lg animate__animated animate__pulse animate__infinite">
                        Proceed to Delivery Address <i class="fa-solid fa-arrow-right ms-2"></i>
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>

<style>
    .fw-800 { font-weight: 800; }
    /* Desktop vs Mobile adjustments */
    @media (max-width: 576px) {
        .sk-card { text-align: center; }
        .text-truncate { white-space: normal; } /* Mobile par poora naam dikhe */
        .btn-lg { font-size: 1.1rem; }
    }
    
    /* Animation speed control */
    .animate__animated { --animate-duration: 0.5s; }
</style>
</body>
</html>