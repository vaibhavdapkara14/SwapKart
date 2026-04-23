<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-4 py-md-5">
    <!-- HEADER SECTION: Responsive Flex -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 mb-md-5 gap-3 text-center text-md-start">
        <h2 class="fw-800 mb-0">👑 Master Admin Dashboard</h2>
        <span class="badge bg-danger rounded-pill px-4 py-2 shadow-sm">Master Control</span>
    </div>

    <!-- STATS CARDS: Responsive Grid -->
    <div class="row g-3 g-md-4 mb-5">
        <!-- Card 1 -->
        <div class="col-12 col-sm-6 col-md-4">
            <div class="sk-card p-4 text-center shadow border-0 h-100 animate__animated animate__fadeIn">
                <i class="fa-solid fa-users fa-2x text-primary mb-2"></i>
                <div class="text-muted small fw-bold">TOTAL USERS</div>
                <h2 class="fw-800 mb-0">${totalUsers}</h2>
            </div>
        </div>
        <!-- Card 2 -->
        <div class="col-12 col-sm-6 col-md-4">
            <div class="sk-card p-4 text-center shadow border-0 h-100 animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
                <i class="fa-solid fa-boxes-stacked fa-2x text-info mb-2"></i>
                <div class="text-muted small fw-bold">TOTAL LISTINGS</div>
                <h2 class="fw-800 mb-0">${totalProducts}</h2>
            </div>
        </div>
        <!-- Card 3 -->
        <div class="col-12 col-md-4">
            <div class="sk-card p-4 text-center shadow border-0 h-100 animate__animated animate__fadeIn" 
                 style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white; animation-delay: 0.2s;">
                <i class="fa-solid fa-vault fa-2x mb-2"></i>
                <div class="small fw-bold opacity-75">WALLET CIRCULATION</div>
                <h2 class="fw-800 mb-0 text-white">₹ ${platformBalance}</h2>
            </div>
        </div>
    </div>

    <!-- TABS SECTION: Scrollable on mobile -->
    <div class="sk-card p-3 p-md-4 shadow-lg border-0">
        <ul class="nav nav-pills mb-4 gap-2 flex-nowrap overflow-auto pb-2" id="adminTabs" style="scrollbar-width: thin;">
            <li class="nav-item">
                <button class="nav-link active rounded-pill fw-bold text-nowrap" data-bs-toggle="pill" data-bs-target="#orders-tab">Orders & Delivery</button>
            </li>
            <li class="nav-item">
                <button class="nav-link rounded-pill fw-bold text-nowrap" data-bs-toggle="pill" data-bs-target="#users-tab">User Management</button>
            </li>
            <li class="nav-item">
                <button class="nav-link rounded-pill fw-bold text-nowrap" data-bs-toggle="pill" data-bs-target="#inventory-tab">Full Inventory</button>
            </li>
        </ul>

        <div class="tab-content">
            <!-- 1. ORDERS TAB -->
            <div class="tab-pane fade show active" id="orders-tab">
                <div class="table-responsive"> <!-- Table Container for responsiveness -->
                    <table class="table align-middle">
                        <thead class="text-muted small">
                            <tr><th>OID</th><th>ITEM</th><th>BUYER & ADDRESS</th><th>STATUS</th><th>ACTION</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ord" items="${allOrders}">
                                <tr>
                                    <td class="fw-bold">#${ord.id}</td>
                                    <td class="text-primary fw-bold text-nowrap">${ord.productTitle}</td>
                                    <td style="min-width: 200px;">
                                        <b>${ord.shippingName}</b><br>
                                        <small class="text-muted">${ord.shippingAddress}, ${ord.city}</small>
                                    </td>
                                    <td><span class="badge rounded-pill bg-primary">${ord.status}</span></td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-dark dropdown-toggle" data-bs-toggle="dropdown">Update</button>
                                            <ul class="dropdown-menu border-0 shadow">
                                                <li><a class="dropdown-item" href="updateOrderStatus?id=${ord.id}&status=Shipped">Mark Shipped</a></li>
                                                <li><a class="dropdown-item" href="updateOrderStatus?id=${ord.id}&status=Delivered">Mark Delivered</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 2. USERS TAB -->
            <div class="tab-pane fade" id="users-tab">
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="text-muted small">
                            <tr><th>UID</th><th>FULL NAME</th><th>EMAIL</th><th>BALANCE</th><th>ROLE</th><th>ACTION</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${allUsers}">
                                <tr>
                                    <td>#${u.id}</td>
                                    <td class="fw-bold text-nowrap">${u.fullName}</td>
                                    <td>${u.email}</td>
                                    <td class="text-success fw-bold text-nowrap">₹ ${u.walletBalance}</td>
                                    <td><span class="badge bg-secondary">${u.role}</span></td>
                                    <td>
                                        <c:if test="${u.role != 'ADMIN'}">
                                            <a href="deleteUser?id=${u.id}" class="text-danger" onclick="return confirm('Are you sure?')"><i class="fa-solid fa-user-xmark"></i></a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 3. INVENTORY TAB -->
            <div class="tab-pane fade" id="inventory-tab">
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="text-muted small">
                            <tr><th>IMAGE</th><th>TITLE</th><th>PRICE</th><th>SELLER</th><th>STATUS</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${allProducts}">
                                <tr>
                                    <td><img src="${p.image}" onerror="this.src='https://placehold.co/40x40?text=Item'" width="40" height="40" class="rounded me-2 shadow-sm" style="object-fit: cover;"></td>
                                    <td class="fw-bold text-nowrap">${p.title}</td>
                                    <td class="text-success fw-bold text-nowrap">₹ ${p.price}</td>
                                    <td class="text-nowrap">${p.sellerName}</td>
                                    <td><span class="badge ${p.status == 'Sold' ? 'bg-danger' : 'bg-success'}">${p.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .fw-800 { font-weight: 800; }
    .nav-pills .nav-link.active { background: var(--primary-gradient) !important; color: white !important; }
    .nav-link { color: var(--text-muted); border: 1px solid var(--border); transition: 0.2s; }
    .table td, .table th { border-bottom: 1px solid rgba(0,0,0,0.05); padding: 12px 10px; }
    
    /* Horizontal Scrollbar hide for cleaner look on Chrome/Safari */
    #adminTabs::-webkit-scrollbar {
        height: 4px;
    }
    #adminTabs::-webkit-scrollbar-thumb {
        background: #ccc;
        border-radius: 10px;
    }
</style>
</body>
</html>