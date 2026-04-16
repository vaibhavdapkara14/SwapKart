<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-5">
    <div class="row mb-4 animate__animated animate__fadeInDown">
        <div class="col-12">
            <h2 class="fw-800"><i class="fa-solid fa-clock-history text-primary me-2"></i> Order History</h2>
            <p class="text-muted">Track your recent purchases and delivery details.</p>
        </div>
    </div>

    <c:if test="${empty orders}">
        <div class="sk-card p-5 text-center shadow-sm">
            <i class="fa-solid fa-box-open fa-4x text-muted mb-3"></i>
            <h4 class="text-muted">Aapne abhi tak koi order nahi kiya hai!</h4>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3 rounded-pill px-4 fw-bold">Explore Marketplace</a>
        </div>
    </c:if>

    <div class="row g-4">
        <c:forEach var="o" items="${orders}">
            <div class="col-12">
                <div class="sk-card p-4 shadow animate__animated animate__fadeInUp">
                    <div class="row align-items-center">
                        <!-- Product Image -->
                        <div class="col-md-2 text-center mb-3 mb-md-0">
                        <img src="${o.productImage}" onerror="this.src='https://placehold.co/400x300?text=No+Image'"
                                 class="rounded-3 shadow-sm" style="width: 100px; height: 100px; object-fit: cover;">
                        </div>

                        <!-- Product & Order Info -->
                        <div class="col-md-4">
                            <h5 class="fw-bold mb-1">${o.productTitle}</h5>
                            <p class="text-success fw-800 mb-2">₹ ${o.amount}</p>
                            <div class="text-muted" style="font-size: 12px;">
                                <span><i class="fa-solid fa-calendar-day me-1"></i> ${o.orderDate}</span><br>
                                <span><i class="fa-solid fa-hashtag me-1"></i> TXN: ${o.transactionId}</span>
                            </div>
                        </div>

                        <!-- ACTUAL DELIVERY ADDRESS (CHANGE DONE HERE) -->
                        <div class="col-md-4">
                            <div class="p-3 rounded-4 bg-light text-dark border shadow-inner">
                                <small class="text-primary fw-bold d-block mb-1"><i class="fa-solid fa-location-dot me-1"></i> DELIVERY DETAILS:</small>
                                <div style="font-size: 13px; line-height: 1.5;">
                                    <b>${o.shippingName}</b> <span class="text-muted">(${o.shippingMobile})</span><br>
                                    ${o.shippingAddress}<br>
                                    ${o.city}, ${o.state} - ${o.pincode}
                                </div>
                            </div>
                        </div>

                        <!-- Status & OTP -->
                        <div class="col-md-2 text-center mt-3 mt-md-0">
                            <span class="badge ${o.status == 'Delivered' ? 'bg-success' : 'bg-primary'} rounded-pill px-3 py-2 mb-2">
                                ${o.status}
                            </span>
                            
                            <c:if test="${o.status == 'Out for Delivery'}">
                                <div class="mt-2">
                                    <small class="d-block text-muted small fw-bold">DELIVERY OTP:</small>
                                    <h4 class="text-primary fw-800 animate__animated animate__pulse animate__infinite">${o.deliveryOtp}</h4>
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
    .shadow-inner { box-shadow: inset 0 2px 4px rgba(0,0,0,0.06); }
    .fw-800 { font-weight: 800; }
</style>
</body>
</html>