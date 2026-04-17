<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-5">
    <h2 class="fw-800 mb-4"><i class="fa-solid fa-clock-history text-primary me-2"></i> Order History</h2>

    <c:if test="${empty orders}">
        <div class="sk-card p-5 text-center shadow-sm">
            <h4 class="text-muted">Aapne abhi tak koi order nahi kiya hai!</h4>
            <a href="products" class="btn btn-primary mt-3 rounded-pill px-4 fw-bold text-white">Explore Marketplace</a>
        </div>
    </c:if>

    <div class="row g-4">
        <c:forEach var="o" items="${orders}">
            <div class="col-12">
                <div class="sk-card p-4 shadow animate__animated animate__fadeInUp">
                    <div class="row align-items-center">
                        <div class="col-md-2 text-center mb-3 mb-md-0">
                            <!-- Cloudinary Direct Link -->
                            <img src="${o.productImage}" onerror="this.src='https://placehold.co/400x300?text=No+Image'"
                                 class="rounded-3 shadow-sm" style="width: 100px; height: 100px; object-fit: cover;">
                        </div>
                        <div class="col-md-4">
                            <h5 class="fw-bold mb-1 text-main">${o.productTitle}</h5>
                            <p class="text-success fw-800 mb-2">₹ ${o.amount}</p>
                            <small class="text-muted d-block small">TXN: ${o.transactionId}</small>
                        </div>
                        <div class="col-md-4">
                            <div class="p-3 rounded-4 bg-light text-dark border shadow-inner">
                                <small class="text-primary fw-bold d-block mb-1">DELIVERY ADDRESS:</small>
                                <div style="font-size: 13px;">
                                    <b>${o.shippingName}</b> (${o.shippingMobile})<br>
                                    ${o.shippingAddress}, ${o.city} - ${o.pincode}
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2 text-center mt-3 mt-md-0">
                            <span class="badge ${o.status == 'Delivered' ? 'bg-success' : 'bg-primary'} rounded-pill px-3 py-2 mb-2">
                                ${o.status}
                            </span>
                            <c:if test="${o.status == 'Out for Delivery'}">
                                <small class="d-block text-muted fw-bold">OTP: ${o.deliveryOtp}</small>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>