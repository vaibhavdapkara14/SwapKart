<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- Mobile support ke liye meta tag -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
    <title>${p.title} | SwapKart</title>

    <style>
        .details-container {
            width: 95%;
            max-width: 1200px;
            margin: 20px auto;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            color: #6366f1;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
            font-size: 14px;
        }
        .back-btn:hover { transform: translateX(-5px); color: #a855f7; }

        /* Main Grid Wrapper */
        .details-box {
            border-radius: 24px;
            overflow: hidden;
        }

        /* Image Styling */
        .product-img {
            width: 100%;
            max-height: 550px;
            border-radius: 20px;
            object-fit: cover;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: 0.4s;
        }

        .category-badge {
            padding: 5px 15px;
            background: rgba(99, 102, 241, 0.15);
            color: #6366f1;
            border: 1px solid rgba(99, 102, 241, 0.3);
            border-radius: 50px;
            display: inline-block;
            font-weight: 700;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .title {
            font-size: clamp(1.5rem, 4vw, 2.2rem); /* Dynamic Font */
            font-weight: 800;
            margin-bottom: 10px;
            line-height: 1.2;
        }

        .price {
            font-size: 1.8rem;
            font-weight: 800;
            color: #10b981;
            margin-bottom: 20px;
        }

        /* Specs & Description Area */
        .description-box {
            margin-top: 25px;
            padding: 20px;
            border-radius: 20px;
            background: rgba(99, 102, 241, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.1);
            white-space: pre-line; 
            font-size: 15px;
            line-height: 1.7;
        }

        /* Action Sidebar */
        .action-card {
            padding: 25px;
            border-radius: 24px;
            background: var(--card-bg);
            border: 1px solid var(--border);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .btn-main-cart {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            width: 100%; padding: 15px; border-radius: 14px;
            background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            color: white !important; font-weight: 700; text-decoration: none;
            margin-bottom: 12px; transition: 0.3s;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.3); border: none;
        }
        .btn-main-cart:hover { transform: translateY(-3px); box-shadow: 0 12px 25px rgba(99, 102, 241, 0.4); }

        .btn-contact {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            width: 100%; padding: 14px; border-radius: 14px;
            background: transparent; color: var(--text-main) !important;
            border: 2px solid #6366f1; font-weight: 700; text-decoration: none; transition: 0.3s;
        }

        .seller-badge { display: flex; align-items: center; gap: 12px; margin-bottom: 15px; }
        .seller-avatar {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--primary-gradient); display: flex; align-items: center;
            justify-content: center; color: white; font-weight: 800;
        }

        .status-sold {
            background: #fee2e2; color: #b91c1c; padding: 12px;
            border-radius: 14px; text-align: center; font-weight: 800; margin-bottom: 15px;
        }

        /* Delivery Box Theme Fix */
        .delivery-info-box {
            margin-top: 25px; padding: 15px; border-radius: 18px;
            background: var(--card-bg); border: 1px solid var(--border);
            display: flex; align-items: center; gap: 15px;
        }

        /* Mobile specific spacing */
        @media (max-width: 768px) {
            .details-container { padding: 0 10px; }
            .sk-card { padding: 20px !important; }
            .btn-main-cart, .btn-contact { padding: 12px; font-size: 14px; }
        }
    </style>
</head>

<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<div class="container-fluid details-container">

    <!-- Back Button -->
    <a href="${pageContext.request.contextPath}/products" class="back-btn animate__animated animate__fadeInLeft">
        <i class="fa-solid fa-arrow-left me-2"></i> Back to Market
    </a>

    <!-- Bootstrap Row for side-by-side on desktop, stacked on mobile -->
    <div class="row g-4 sk-card p-3 p-md-4 shadow animate__animated animate__fadeIn">
        
        <!-- Image Column -->
        <div class="col-12 col-lg-5">
            <img src="${p.image}" 
                 onerror="this.src='https://placehold.co/600x600?text=No+Product+Image'"
                 class="product-img shadow-sm mb-3">
            
            <div class="description-box">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-circle-info me-2 text-primary"></i> Specifications & Details</h6>
                <div style="opacity: 0.9;">
                    <c:out value="${p.description}" />
                </div>
            </div>
        </div>

        <!-- Info Column -->
        <div class="col-12 col-lg-7">
            <div class="ps-lg-3">
                <span class="category-badge">${p.category}</span>
                <h1 class="title">${p.title}</h1>
                
                <div class="price">₹ ${p.price}</div>
                
                <div class="text-muted small mb-4">
                    <i class="fa-regular fa-eye me-1"></i> ${p.viewCount} people viewed this
                </div>

                <hr class="opacity-25">

                <!-- Seller & Action Card -->
                <div class="action-card mt-4">
                    <div class="seller-badge">
                        <div class="seller-avatar">${p.sellerName.substring(0,1).toUpperCase()}</div>
                        <div>
                            <small class="text-muted d-block fw-bold" style="font-size: 10px; letter-spacing: 1px;">LISTED BY</small>
                            <h6 class="mb-0 fw-bold">${p.sellerName}</h6>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${p.status == 'Sold'}">
                            <div class="status-sold animate__animated animate__headShake">
                                <i class="fa-solid fa-circle-xmark me-2"></i> ITEM UNAVAILABLE
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/addToCart?id=${p.id}" class="btn-main-cart">
                                <i class="fa-solid fa-cart-shopping me-2"></i> ADD TO MY CART
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <a href="tel:${p.sellerContact}" class="btn-contact">
                        <i class="fa-solid fa-phone me-2"></i> CONTACT SELLER
                    </a>
                </div>

                <!-- Delivery Features -->
                <div class="delivery-info-box">
                    <i class="fa-solid fa-truck-fast fa-2x text-primary"></i>
                    <div>
                        <h6 class="mb-0 fw-bold">Verified Delivery</h6>
                        <small class="text-muted">Safe doorstep swapping via OTP verification.</small>
                    </div>
                </div>

                <div class="mt-4 text-center">
                    <p class="text-muted small"><i class="fa-solid fa-shield-halved me-1 text-primary"></i> 100% Genuine Marketplace Guarantee</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>