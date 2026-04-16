<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Professional Logo (Favicon) -->
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/599/599305.png">
    <title>Marketplace | SwapKart</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* --- DYNAMIC STYLING --- */
        :root {
            --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            --glass-bg: rgba(255, 255, 255, 0.95);
        }

        .dark-theme {
            --glass-bg: rgba(255, 255, 255, 0.08);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: 0.3s ease;
        }

        /* --- MODERN SEARCH STRIP --- */
        .search-strip {
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(15px);
            padding: 20px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .search-box, .cat-select {
            background: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.2) !important;
            border-radius: 12px;
            color: white !important;
            padding: 10px 20px;
            font-weight: 500;
        }

        .btn-search {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 0 25px;
            color: white;
            font-weight: 700;
        }

        /* --- PRODUCT CARDS --- */
        .main-wrapper {
            max-width: 1250px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .section-title {
            font-weight: 800;
            font-size: 28px;
            margin-bottom: 30px;
        }

        .sk-card {
            background: var(--glass-bg);
            border-radius: 24px;
            overflow: hidden;
            position: relative;
            transition: all 0.4s ease;
            border: 1px solid var(--border);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .sk-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        .img-wrapper {
            width: 100%; height: 200px;
            background: #f1f5f9; position: relative;
            overflow: hidden;
        }

        .img-wrapper img { 
            width: 100%; height: 100%; 
            object-fit: cover; 
            transition: 0.5s;
        }

        .sk-card:hover .img-wrapper img { transform: scale(1.1); }

        .wishlist-btn {
            position: absolute; top: 15px; right: 15px;
            background: white; width: 36px; height: 36px;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            text-decoration: none; box-shadow: 0 4px 10px rgba(0,0,0,0.1); 
            z-index: 5; color: #64748b; transition: 0.3s;
        }

        .wishlist-btn:hover { color: #ef4444; transform: scale(1.1); }

        .badge-status {
            position: absolute; top: 15px; left: 15px;
            padding: 5px 12px; border-radius: 8px; font-weight: 800;
            font-size: 11px; text-transform: uppercase; z-index: 5;
            background: rgba(99, 102, 241, 0.2); color: #6366f1;
            border: 1px solid rgba(99, 102, 241, 0.3);
        }

        .price-tag { font-size: 22px; font-weight: 800; color: #10b981; margin: 0; }
        .item-title { font-size: 15px; font-weight: 600; margin-bottom: 12px; }

        .btn-details {
            padding: 10px; border-radius: 12px;
            background: rgba(99, 102, 241, 0.1); color: #6366f1; font-weight: 700;
            text-decoration: none; font-size: 13px; text-align: center; flex: 1;
        }

        .btn-cart-buy {
    padding: 10px;
    border-radius: 12px;
    background: var(--primary-gradient); /* FIXED */
    color: black !important;  /* 👈 TEXT BLACK */
    font-weight: 700;
    text-decoration: none;
    font-size: 13px;
    text-align: center;
    flex: 1;
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
}
        .sort-select {
            background: transparent; border: none; color: #94a3b8;
            font-weight: 700; cursor: pointer; outline: none;
        }
    </style>
</head>

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<jsp:include page="header.jsp"/>

<!-- SEARCH STRIP -->
<form action="${pageContext.request.contextPath}/products" method="get" id="filterForm">
    <div class="search-strip">
        <div class="container d-flex gap-2">
            <select name="category" class="cat-select" onchange="this.form.submit()">
                <option value="All">All Categories</option>
                <option value="Mobile" ${param.category == 'Mobile' ? 'selected' : ''}>Mobile</option>
                <option value="Electronics" ${param.category == 'Electronics' ? 'selected' : ''}>Electronics</option>
                <option value="Furniture" ${param.category == 'Furniture' ? 'selected' : ''}>Furniture</option>
            </select>

            <input type="text" name="keyword" class="search-box flex-grow-1" placeholder="Search for items..." value="${param.keyword}">
            
            <button type="submit" class="btn-search">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </div>
    </div>

    <!-- SORTING BAR -->
    <div class="container mt-3 d-flex justify-content-between align-items-center">
        <span class="text-muted small fw-bold">MARKETPLACE: <span class="text-primary">${list.size()} Items</span></span>
        <div class="d-flex align-items-center gap-2">
            <i class="fa-solid fa-filter text-muted"></i>
            <select name="sortBy" class="sort-select" onchange="this.form.submit()">
                <option value="">Default Sort</option>
                <option value="lowToHigh" ${param.sortBy == 'lowToHigh' ? 'selected' : ''}>Price: Low to High</option>
                <option value="highToLow" ${param.sortBy == 'highToLow' ? 'selected' : ''}>Price: High to Low</option>
            </select>
        </div>
    </div>
</form>

<div class="main-wrapper">
    <h2 class="section-title animate__animated animate__fadeIn">Featured Deals 🔥</h2>
    
    <div class="product-grid row g-4">
        <c:forEach var="p" items="${list}">
            <div class="col-6 col-md-4 col-lg-3">
                <div class="sk-card animate__animated animate__fadeInUp">
                    <!-- Wishlist -->
                    <a href="${pageContext.request.contextPath}/addToWishlist?id=${p.id}" class="wishlist-btn" title="Save for later">
                        <i class="fa-solid fa-heart"></i>
                    </a>

                    <!-- Image -->
                    <div class="img-wrapper">
                        <span class="badge-status">${p.category}</span>
                        <img src="${pageContext.request.contextPath}/assets/img/${p.image}" 
                             onerror="this.src='https://placehold.co/400x300?text=SwapKart+Item'">
                    </div>

                    <!-- Content -->
                    <div class="p-3 flex-grow-1">
                        <h3 class="price-tag mb-1">₹${p.price}</h3>
                        <p class="item-title text-truncate mb-3">${p.title}</p>
                        <div class="d-flex justify-content-between text-muted small fw-bold">
                            <span><i class="fa-solid fa-user-ninja me-1"></i> ${p.sellerName.split(' ')[0]}</span>
                            <span><i class="fa-regular fa-eye me-1"></i> ${p.viewCount}</span>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="p-3 pt-0 d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/product/details?id=${p.id}" class="btn-details">
                            View
                        </a>
                        <c:if test="${p.status != 'Sold'}">
                            <a href="${pageContext.request.contextPath}/addToCart?id=${p.id}" class="btn-cart-buy">
                                <i class="fa-solid fa-cart-plus me-1"></i> Cart
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty list}">
        <div class="text-center py-5">
            <i class="fa-solid fa-store-slash fa-4x mb-3 opacity-25"></i>
            <h3 class="text-muted">No items match your search.</h3>    
        </div>
    </c:if>
</div>

</body>
</html>