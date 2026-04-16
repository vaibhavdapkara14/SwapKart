<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-5" style="max-width: 600px;">
    
    <!-- 1. Wallet Card -->
    <div class="sk-card p-4 mb-4 text-center border-0 shadow">
        <h5 class="text-muted fw-bold small">EARNINGS BALANCE</h5>
        <h1 class="display-5 fw-800 text-success">₹ ${user.walletBalance}</h1>
        <div class="d-flex gap-2 mt-3">
            <button class="btn btn-primary flex-grow-1 rounded-pill" onclick="addMoney()">Add</button>
            <button class="btn btn-outline-danger flex-grow-1 rounded-pill" onclick="withdrawMoney()">Withdraw</button>
        </div>
    </div>

    <!-- 2. SAVED ADDRESSES SECTION -->
    <div class="sk-card p-4 mb-4 shadow">
        <h5 class="fw-bold mb-3">📍 Saved Delivery Addresses</h5>
        <c:forEach var="addr" items="${userAddresses}">
            <div class="p-3 border rounded-4 mb-2 bg-light text-dark shadow-sm">
                <small class="fw-bold d-block text-primary">${addr.receiverName}</small>
                <p class="mb-0 small">${addr.address}, ${addr.city} (${addr.pincode})</p>
            </div>
        </c:forEach>
        <button class="btn btn-sm btn-dark w-100 rounded-pill mt-3" data-bs-toggle="modal" data-bs-target="#addrModal">
            + Add New Address
        </button>
    </div>

    <!-- 3. Profile Info Form -->
    <div class="sk-card p-4 shadow">
        <h5 class="fw-bold mb-3">Edit Profile</h5>
        <form action="updateProfile" method="post">
            <input type="text" name="fullName" class="form-control mb-3" value="${user.fullName}" required>
            <input type="text" name="mobile" class="form-control mb-3" value="${user.mobile}" required>
            <button class="btn btn-primary w-100 rounded-pill fw-bold">Update Profile</button>
        </form>
    </div>
</div>

<!-- Modal for New Address -->
<div class="modal fade" id="addrModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content sk-card border-0">
            <div class="modal-body p-4">
                <h4 class="fw-bold mb-4">New Address</h4>
                <form action="saveAddress" method="post">
                    <input type="text" name="receiverName" class="form-control mb-2" placeholder="Receiver's Name" required>
                    <input type="text" name="receiverMobile" class="form-control mb-2" placeholder="Mobile" required>
                    <textarea name="address" class="form-control mb-2" placeholder="Street Address" required></textarea>
                    <input type="text" name="city" class="form-control mb-2" placeholder="City" required>
                    <input type="text" name="pincode" class="form-control mb-4" placeholder="Pincode" required>
                    <button class="btn btn-primary w-100 rounded-pill fw-bold">Save Now</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>