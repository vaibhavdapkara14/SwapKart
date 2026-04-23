<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- Mobile Meta Tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-4 py-md-5">
    <div class="row mb-4 animate__animated animate__fadeInDown">
        <div class="col-12 text-center text-md-start">
            <h2 class="fw-800" style="font-size: clamp(1.5rem, 5vw, 2.2rem);">
                <i class="fa-solid fa-clock-history text-primary me-2"></i> Order History
            </h2>
            <p class="text-muted small">Track your recent purchases and delivery details.</p>
        </div>
    </div>

    <!-- Empty State -->
    <c:if test="${empty orders}">
        <div class="sk-card p-5 text-center shadow-sm border-0">
            <i class="fa-solid fa-box-open fa-4x text-muted mb-3 opacity-25"></i>
            <h4 class="text-muted">No Order Available</h4>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3 rounded-pill px-4 fw-bold shadow">
                Explore Marketplace
            </a>
        </div>
    </c:if>

    <div class="row g-4">
        <c:forEach var="o" items="${orders}">
            <div class="col-12">
                <!-- Responsive Card Padding and Flex -->
                <div class="sk-card p-3 p-md-4 shadow border-0 animate__animated animate__fadeInUp">
                    <div class="row align-items-center">
                        
                        <!-- 1. Product Image: Responsive column -->
                        <div class="col-12 col-md-2 text-center mb-3 mb-md-0">
                            <img src="${o.productImage}" onerror="this.src='https://placehold.co/400x300?text=No+Image'"
                                 class="rounded-4 shadow-sm border" 
                                 style="width: 100px; height: 100px; object-fit: cover;">
                        </div>

                        <!-- 2. Product Info: Responsive column -->
                        <div class="col-12 col-md-4 text-center text-md-start mb-3 mb-md-0">
                            <h5 class="fw-bold mb-1 text-main">${o.productTitle}</h5>
                            <p class="text-success fw-800 mb-2 fs-5">₹ ${o.amount}</p>
                            <div class="text-muted" style="font-size: 11px;">
                                <span class="d-block mb-1"><i class="fa-solid fa-calendar-day me-1"></i> ${o.orderDate}</span>
                                <span class="d-block"><i class="fa-solid fa-hashtag me-1"></i> TXN: ${o.transactionId}</span>
                            </div>
                        </div>

                        <!-- 3. ADDRESS BOX: Mobile full width, Desktop compact -->
                        <div class="col-12 col-md-4 mb-3 mb-md-0">
                            <div class="p-3 rounded-4 bg-light text-dark border shadow-sm h-100" style="background: rgba(0,0,0,0.02) !important;">
                                <small class="text-primary fw-bold d-block mb-2" style="font-size: 11px; letter-spacing: 0.5px;">
                                    <i class="fa-solid fa-location-dot me-1"></i> DELIVERY DETAILS
                                </small>
                                <div style="font-size: 13px; line-height: 1.5;">
                                    <b class="d-block">${o.shippingName}</b>
                                    <span class="text-muted d-block mb-1">${o.shippingMobile}</span>
                                    <span class="opacity-75">${o.shippingAddress}, ${o.city} - ${o.pincode}</span>
                                </div>
                            </div>
                        </div>

                        <!-- 4. Status & OTP Section -->
                        <div class="col-12 col-md-2 text-center">
                            <div class="d-grid d-md-block">
                                <span class="badge ${o.status == 'Delivered' ? 'bg-success' : 'bg-primary'} rounded-pill px-3 py-2 mb-2 w-100 w-md-auto">
                                    <i class="fa-solid ${o.status == 'Delivered' ? 'fa-circle-check' : 'fa-truck'} me-1"></i>
                                    ${o.status}
                                </span>
                            </div>
                            
                            <!-- Responsive OTP Box -->
                            <c:if test="${o.status == 'Out for Delivery'}">
                                <div class="mt-2 py-2 px-3 rounded-3 border border-warning bg-warning bg-opacity-10 d-inline-block d-md-block">
                                    <small class="d-block text-warning fw-bold" style="font-size: 10px;">DELIVERY OTP</small>
                                    <h4 class="text-warning fw-800 mb-0 animate__animated animate__pulse animate__infinite" style="letter-spacing: 2px;">
                                        ${o.deliveryOtp}
                                    </h4>
                                </div>
                            </c:if>
                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<style>
    .fw-800 { font-weight: 800; }
    
    /* Animation Speed adjustment for smoother feel */
    .animate__animated { --animate-duration: 0.6s; }

    /* Shadow Logic */
    .shadow-inner { box-shadow: inset 0 2px 4px rgba(0,0,0,0.06); }

    /* Mobile specific style overrides */
    @media (max-width: 767px) {
        .container { padding-left: 15px; padding-right: 15px; }
        .sk-card { border-radius: 20px !important; }
        .fs-5 { font-size: 1.1rem !important; }
        .rounded-4 { border-radius: 15px !important; }
    }

    /* Dark Mode internal text visibility safety */
    .dark-theme .bg-light { background: rgba(255, 255, 255, 0.05) !important; color: white !important; border: 1px solid rgba(255,255,255,0.1) !important; }
    .dark-theme .text-dark { color: #f8fafc !important; }
</style>
</body>
</html>