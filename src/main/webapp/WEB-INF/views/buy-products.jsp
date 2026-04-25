<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Naya logic for price formatting --%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
    <title>Explore Products | SwapKart</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* --- DYNAMIC STYLING (Vahi hai jo tune diya) --- */
        :root {
            --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            --glass-bg: rgba(255, 255, 255, 0.95);
            --border: rgba(0, 0, 0, 0.1);
        }

        .dark-theme {
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: 0.3s ease;
            overflow-x: hidden;
        }

        .search-strip {
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(15px);
            padding: 15px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        @media (min-width: 768px) {
            .search-strip { padding: 25px 0; }
        }

        .search-box, .cat-select {
            background: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.2) !important;
            border-radius: 12px;
            color: white !important;
            padding: 10px 15px;
            font-weight: 500;
            font-size: 14px;
        }

        .btn-search {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 0 20px;
            color: white;
            font-weight: 700;
        }

        .main-wrapper {
            max-width: 1250px;
            margin: 20px auto;
            padding: 0 15px;
        }

        @media (min-width: 768px) {
            .main-wrapper { margin: 40px auto; padding: 0 20px; }
        }

        .section-title {
            font-weight: 800;
            font-size: 22px;
            margin-bottom: 20px;
        }
        
        @media (min-width: 768px) {
            .section-title { font-size: 28px; margin-bottom: 30px; }
        }

        .sk-card {
            background: var(--glass-bg);
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            transition: all 0.4s ease;
            border: 1px solid var(--border);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .sk-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }

        .img-wrapper {
            width: 100%; 
            height: 140px;
            background: #f1f5f9; 
            position: relative;
            overflow: hidden;
        }

        @media (min-width: 768px) {
            .img-wrapper { height: 200px; }
        }

        .img-wrapper img { 
            width: 100%; height: 100%; 
            object-fit: cover; 
            transition: 0.5s;
        }

        .wishlist-btn {
            position: absolute; top: 10px; right: 10px;
            background: white; width: 32px; height: 32px;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            text-decoration: none; box-shadow: 0 4px 10px rgba(0,0,0,0.1); 
            z-index: 5; color: #64748b; font-size: 14px;
        }

        .badge-status {
            position: absolute; top: 10px; left: 10px;
            padding: 4px 10px; border-radius: 6px; font-weight: 800;
            font-size: 10px; text-transform: uppercase; z-index: 5;
            background: rgba(99, 102, 241, 0.2); color: #6366f1;
            border: 1px solid rgba(99, 102, 241, 0.3);
        }

        .price-tag { font-size: 18px; font-weight: 800; color: #10b981; margin: 0; }
        @media (min-width: 768px) { .price-tag { font-size: 22px; } }

        .item-title { font-size: 13px; font-weight: 600; color: #64748b; margin-bottom: 8px; }

        .btn-details {
            padding: 8px; border-radius: 10px;
            background: rgba(99, 102, 241, 0.1); color: #6366f1; font-weight: 700;
            text-decoration: none; font-size: 12px; text-align: center; flex: 1;
        }

        .btn-cart-buy {
            padding: 8px; border-radius: 10px;
            background: var(--primary-gradient); color: #fff !important; font-weight: 700;
            text-decoration: none; font-size: 12px; text-align: center; flex: 1;
        }

        .sort-select {
            background: transparent; border: none; color: #94a3b8;
            font-weight: 700; cursor: pointer; outline: none; font-size: 13px;
        }
        
        /* Own Product Badge Style */
        .badge-own {
            background: #64748b; color: white; padding: 8px; border-radius: 10px;
            font-size: 11px; font-weight: 700; text-align: center; flex: 1; opacity: 0.8;
        }
    </style>
</head>

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<jsp:include page="header.jsp"/>

<form action="${pageContext.request.contextPath}/products" method="get" id="filterForm">
    <div class="search-strip">
        <div class="container">
            <div class="row g-2">
                <div class="col-5 col-md-3 col-lg-2">
                    <select name="category" class="cat-select w-100" onchange="this.form.submit()">
                        <option value="All">All Items</option>
                        <option value="Mobile" ${param.category == 'Mobile' ? 'selected' : ''}>Mobile</option>
                        <option value="Laptops" ${param.category == 'Laptops' ? 'selected' : ''}>Laptops</option>
                        <option value="Electronics" ${param.category == 'Electronics' ? 'selected' : ''}>Electronics</option>
                        <option value="Vehicles" ${param.category == 'Vehicles' ? 'selected' : ''}>Vehicles</option>
                    </select>
                </div>
                <div class="col-7 col-md-9 col-lg-10">
                    <div class="input-group">
                        <input type="text" name="keyword" class="search-box form-control" placeholder="Search..." value="${param.keyword}">
                        <button type="submit" class="btn-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-3">
        <div class="d-flex justify-content-between align-items-center">
            <span class="text-muted extra-small fw-bold d-none d-sm-inline">MARKET: <span class="text-primary">${list.size()} Items</span></span>
            <div class="d-flex align-items-center gap-2 ms-auto">
                <i class="fa-solid fa-filter text-muted small"></i>
                <select name="sortBy" class="sort-select" onchange="this.form.submit()">
                    <option value="">Sort: Default</option>
                    <option value="lowToHigh" ${param.sortBy == 'lowToHigh' ? 'selected' : ''}>Price: Low-High</option>
                    <option value="highToLow" ${param.sortBy == 'highToLow' ? 'selected' : ''}>Price: High-Low</option>
                </select>
            </div>
        </div>
    </div>
</form>

<div class="main-wrapper">
    <h2 class="section-title animate__animated animate__fadeIn">Featured Deals 🔥</h2>
    
    <div class="product-grid row g-3 g-md-4">
        <c:forEach var="p" items="${list}">
            <div class="col-6 col-md-4 col-lg-3">
                <div class="sk-card animate__animated animate__fadeInUp">
                    
                    <%-- Enhancement: Show wishlist only for non-owners --%>
                    <c:if test="${sessionScope.user.fullName != p.sellerName}">
                        <a href="${pageContext.request.contextPath}/addToWishlist?id=${p.id}" class="wishlist-btn">
                            <i class="fa-solid fa-heart"></i>
                        </a>
                    </c:if>

                    <div class="img-wrapper">
                        <span class="badge-status">${p.category}</span>
                        <img src="${p.image}" onerror="this.src='https://placehold.co/400x300?text=SwapKart'">
                    </div>

                    <div class="p-2 p-md-3 flex-grow-1">
                        <%-- Enhancement: Better Price Formatting --%>
                        <h3 class="price-tag mb-1">
                            ₹<fmt:formatNumber value="${p.price}" pattern="#,##,###.##"/>
                        </h3>
                        <p class="item-title text-truncate mb-2">${p.title}</p>
                        <div class="d-flex justify-content-between text-muted" style="font-size: 10px;">
                            <span class="text-nowrap"><i class="fa-solid fa-user me-1"></i> ${p.sellerName.split(' ')[0]}</span>
                            <span><i class="fa-regular fa-eye me-1"></i> ${p.viewCount}</span>
                        </div>
                    </div>

                    <div class="p-2 p-md-3 pt-0 d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/product/details?id=${p.id}" class="btn-details">
                            View
                        </a>
                        
                        <%-- Logic Enhancement: Seller Restriction --%>
                        <c:choose>
                            <c:when test="${p.status == 'Sold'}">
                                <%-- Case: Item sold --%>
                            </c:when>
                            <c:when test="${not empty sessionScope.user && sessionScope.user.fullName == p.sellerName}">
                                <%-- Case: Owner looking at own ad --%>
                                <div class="badge-own" title="Bhai, ye tera hi item hai">
                                    <i class="fa-solid fa-user-check me-1"></i> Mine
                                </div>
                            </c:when>
                            <c:otherwise>
                                <%-- Case: Normal buyer --%>
                                <a href="${pageContext.request.contextPath}/addToCart?id=${p.id}" class="btn-cart-buy">
                                    <i class="fa-solid fa-cart-plus"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty list}">
        <div class="text-center py-5">
            <i class="fa-solid fa-store-slash fa-3x mb-3 opacity-25"></i>
            <h5 class="text-muted">No items found.</h5>    
        </div>
    </c:if>
</div>

</body>
</html>