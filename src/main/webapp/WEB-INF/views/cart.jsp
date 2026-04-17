<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-5" style="max-width: 800px;">
    <h2 class="fw-800 mb-4">🛒 My Shopping Cart</h2>
    
    <c:forEach var="item" items="${cartList}">
        <div class="sk-card p-3 mb-3 d-flex align-items-center justify-content-between shadow-sm">
            <div class="d-flex align-items-center">
                <!-- item.product.image fetch data correctly -->
                <img src="${item.product.image}" onerror="this.src='https://placehold.co/300x200?text=No+Image'" 
                     width="70" height="60" style="object-fit: cover;" class="rounded me-3">
                <div>
                    <h6 class="mb-0 fw-bold text-main">${item.product.title}</h6>
                    <span class="text-success fw-bold">₹ ${item.product.price}</span>
                </div>
            </div>
            <a href="removeFromCart?id=${item.cartId}" class="text-danger small text-decoration-none">
                <i class="fa-solid fa-trash-can"></i> Remove
            </a>
        </div>
    </c:forEach>

    <c:if test="${empty cartList}">
        <div class="sk-card p-5 text-center">
            <h4 class="text-muted">Bhai, cart khali hai.</h4>
            <a href="products" class="btn btn-primary rounded-pill px-4 mt-2 text-white">Browse Market</a>
        </div>
    </c:if>

    <c:if test="${not empty cartList}">
        <div class="sk-card p-4 text-center mt-4 border-primary shadow">
            <h1 class="text-primary fw-800 mb-4">₹ ${totalPrice}</h1>
            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold shadow">
                Proceed to Delivery Address <i class="fa-solid fa-arrow-right ms-2"></i>
            </a>
        </div>
    </c:if>
</div>
</body>
</html>