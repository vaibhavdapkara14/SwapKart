<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/599/599305.png">
    <title>${p.title} - Details | SwapKart</title>

    <style>
        .details-container {
            width: 95%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            color: #6366f1;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
        }
        .back-btn:hover { transform: translateX(-5px); color: #a855f7; }

        /* Main Details Box */
        .details-box {
            display: flex;
            gap: 50px;
            padding: 40px;
            border-radius: 30px;
            flex-wrap: wrap;
        }

        .img-section {
            flex: 0 0 450px;
            max-width: 100%;
        }

        .product-img {
            width: 100%;
            border-radius: 24px;
            object-fit: cover;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            transition: 0.4s;
        }
        .product-img:hover { transform: scale(1.02); }

        .info-section {
            flex: 1;
            min-width: 300px;
        }

        .category-badge {
            padding: 6px 18px;
            background: rgba(99, 102, 241, 0.15);
            color: #6366f1;
            border: 1px solid rgba(99, 102, 241, 0.3);
            border-radius: 50px;
            display: inline-block;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            margin-bottom: 15px;
        }

        .title {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 10px;
            line-height: 1.2;
        }

        .price-row {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
        }

        .price {
            font-size: 32px;
            font-weight: 800;
            color: #10b981;
        }

        /* Description & Specs Box */
        .description-box {
            margin-top: 30px;
            padding: 25px;
            border-radius: 20px;
            background: rgba(99, 102, 241, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.1);
            /* ZAROORI: Isse specifications line-by-line aayenge */
            white-space: pre-line; 
            font-size: 16px;
            line-height: 1.8;
        }

        /* Sidebar Action Area */
        .action-card {
            margin-top: 30px;
            padding: 30px;
            border-radius: 24px;
            background: var(--card-bg);
            border: 1px solid var(--border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .btn-main-cart {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            width: 100%;
            padding: 16px;
            border-radius: 16px;
            background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            color: white !important;
            font-weight: 700;
            text-decoration: none;
            margin-bottom: 15px;
            transition: 0.3s;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.3);
            border: none;
        }
        .btn-main-cart:hover { transform: translateY(-3px); box-shadow: 0 12px 30px rgba(99, 102, 241, 0.4); }

        .btn-contact {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            width: 100%;
            padding: 15px;
            border-radius: 16px;
            background: transparent;
            color: var(--text-main) !important;
            border: 2px solid #6366f1;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
        }
        .btn-contact:hover { background: rgba(99, 102, 241, 0.05); }

        .seller-badge {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }
        .seller-avatar {
            width: 45px; height: 45px;
            border-radius: 50%;
            background: var(--primary-gradient);
            display: flex; align-items: center; justify-content: center;
            color: white; font-weight: 800;
        }

        .status-tag {
            background: #fee2e2;
            color: #b91c1c;
            padding: 12px;
            border-radius: 15px;
            text-align: center;
            font-weight: 800;
            margin-bottom: 20px;
        }

        @media (max-width: 992px) {
            .details-box { flex-direction: column; padding: 20px; }
            .img-section { flex: 0 0 100%; }
        }
    </style>
</head>

<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<div class="details-container">

    <!-- Back Navigation -->
    <a href="${pageContext.request.contextPath}/products" class="back-btn animate__animated animate__fadeInLeft">
        <i class="fa-solid fa-arrow-left me-2"></i> Back to Market
    </a>

    <div class="details-box sk-card animate__animated animate__fadeIn">

        <!-- 1. Product Image Section -->
        <div class="img-section">
            <img src="${pageContext.request.contextPath}/assets/img/${p.image}" 
                 onerror="this.src='https://placehold.co/600x600?text=Product+Image'"
                 class="product-img">
            
            <div class="description-box mt-4">
                <h5 class="fw-bold mb-3"><i class="fa-solid fa-circle-info me-2 text-primary"></i> Product Info & Specs</h5>
                <c:out value="${p.description}" />
            </div>
        </div>

        <!-- 2. Product Info & Action Section -->
        <div class="info-section">
            <span class="category-badge">${p.category}</span>
            <h1 class="title">${p.title}</h1>
            
            <div class="price-row">
                <span class="price">₹ ${p.price}</span>
                <span class="text-muted small"><i class="fa-regular fa-eye me-1"></i> ${p.viewCount} views</span>
            </div>

            <hr style="opacity: 0.1;">

            <!-- Seller & Buy Card -->
            <div class="action-card">
                <div class="seller-badge">
                    <div class="seller-avatar">${p.sellerName.substring(0,1).toUpperCase()}</div>
                    <div>
                        <small class="text-muted d-block fw-bold" style="letter-spacing: 1px;">VERIFIED SELLER</small>
                        <h6 class="mb-0 fw-bold">${p.sellerName}</h6>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${p.status == 'Sold'}">
                        <div class="status-tag">
                            <i class="fa-solid fa-shop-slash me-2"></i> THIS ITEM IS SOLD
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/addToCart?id=${p.id}" class="btn-main-cart">
                            <i class="fa-solid fa-cart-arrow-down"></i> ADD TO MY CART
                        </a>
                    </c:otherwise>
                </c:choose>

                <a href="tel:${p.sellerContact}" class="btn-contact mt-2">
                    <i class="fa-solid fa-phone-volume"></i> CALL SELLER
                </a>
                
                <p class="text-center text-muted small mt-3 mb-0">
                    <i class="fa-solid fa-shield-halved me-1"></i> SwapKart Buyer Protection Enabled
                </p>
            </div>

            <!-- Promotion Tag -->
            <div class="mt-4 p-3 rounded-4 border d-flex align-items-center gap-3 bg-light text-dark">
                <i class="fa-solid fa-truck-fast fa-2x text-primary"></i>
                <div>
                    <h6 class="mb-0 fw-bold">Fast Home Delivery</h6>
                    <small>Get this item delivered within 24-48 hours.</small>
                </div>
            </div>

        </div>

    </div>

</div>

</body>
</html>