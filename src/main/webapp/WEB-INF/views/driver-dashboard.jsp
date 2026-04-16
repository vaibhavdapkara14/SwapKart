<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-5">
    <h2 class="fw-800 mb-4 text-primary">🚚 Delivery Partner Jobs</h2>
    <div class="row g-4">
        <c:forEach var="o" items="${availableOrders}">
            <div class="col-md-6">
                <div class="sk-card p-4 border-start border-4 border-warning">
                    <h5 class="fw-bold">${o.productTitle}</h5>
                    
                    <!-- YAHAN ADDRESS DIKHEGA DRIVER KO -->
                    <div class="p-3 my-3 rounded-3 bg-dark text-white shadow-inner">
                        <small class="text-warning fw-bold"><i class="fa-solid fa-map-pin"></i> CUSTOMER ADDRESS:</small>
                        <p class="mb-0 small">${o.shippingAddress}, ${o.city}, ${o.state} - ${o.pincode}</p>
                    </div>
                    
                    <a href="acceptOrder?id=${o.id}" class="btn btn-warning w-100 fw-bold">Accept & Start Delivery</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>