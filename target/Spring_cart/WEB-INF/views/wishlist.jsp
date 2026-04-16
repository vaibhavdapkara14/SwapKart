<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>

<link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
    <title>My Wishlist - SwapKart</title>
    <style>
        .wishlist-container { width: 80%; margin: 30px auto; }
        .wishlist-item { 
            display: flex; 
            align-items: center; 
            border: 1px solid #ddd; 
            padding: 15px; 
            margin-bottom: 15px; 
            border-radius: 8px;
            background: #fff;
        }
        .wishlist-item img { width: 120px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 20px; }
        .item-details { flex-grow: 1; }
        .item-details h3 { margin: 0 0 5px 0; color: #333; }
        .price { color: green; font-weight: bold; font-size: 18px; }
        .remove-btn { color: #ff4444; text-decoration: none; font-weight: bold; border: 1px solid #ff4444; padding: 5px 10px; border-radius: 4px; }
        .remove-btn:hover { background: #ff4444; color: white; }
        .view-btn { background: #007bff; color: white; padding: 6px 12px; text-decoration: none; border-radius: 4px; margin-right: 10px; }
    </style>
</head>
<body style="background: #f8f9fa;">
<jsp:include page="header.jsp"/>

<div class="wishlist-container">
    <h2> My Saved Items</h2>
    <hr>

    <c:if test="${empty list}">
        <div style="text-align: center; margin-top: 50px;">
            <p style="font-size: 18px; color: gray;">Your wishlist is empty.</p>
            <a href="${pageContext.request.contextPath}/products" style="color: #007bff;">Browse Products</a>
        </div>
    </c:if>

    <c:forEach var="p" items="${list}">
        <div class="wishlist-item">
            <img src="${pageContext.request.contextPath}/assets/img/${p.image}" alt="Product">
            
            <div class="item-details">
                <h3>${p.title}</h3>
                <p style="color: gray; font-size: 14px; margin: 5px 0;">Category: ${p.category}</p>
                <div class="price">₹ ${p.price}</div>
            </div>

            <div>
                <a href="${pageContext.request.contextPath}/product/details?id=${p.id}" class="view-btn">View</a>
                <a href="${pageContext.request.contextPath}/removeFromWishlist?id=${p.id}" class="remove-btn" onclick="return confirm('Remove from wishlist?')">Remove</a>
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>