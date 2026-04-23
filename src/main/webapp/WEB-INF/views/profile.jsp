<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- Mobile Meta Tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-4 py-md-5" style="max-width: 650px;">
    
    <!-- 1. Wallet Card - Responsive Flex -->
    <div class="sk-card p-4 mb-4 text-center border-0 shadow animate__animated animate__fadeIn">
        <h5 class="text-muted fw-bold small mb-2" style="letter-spacing: 1px;">EARNINGS BALANCE</h5>
        <h1 class="display-5 fw-800 text-success mb-3">₹ ${user.walletBalance}</h1>
        
        <div class="row g-2 mt-2">
            <div class="col-6">
                <button class="btn btn-primary w-100 rounded-pill fw-bold py-2 shadow-sm" onclick="addMoney()">
                    <i class="fa-solid fa-plus-circle me-1"></i> Add
                </button>
            </div>
            <div class="col-6">
                <button class="btn btn-outline-danger w-100 rounded-pill fw-bold py-2" onclick="withdrawMoney()">
                    <i class="fa-solid fa-money-bill-transfer me-1"></i> Withdraw
                </button>
            </div>
        </div>
    </div>

    <!-- 2. SAVED ADDRESSES SECTION - List responsive -->
    <div class="sk-card p-4 mb-4 shadow border-0 animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
        <h5 class="fw-bold mb-3"><i class="fa-solid fa-map-location-dot text-primary me-2"></i> Saved Delivery Addresses</h5>
        
        <div class="address-list" style="max-height: 300px; overflow-y: auto; scrollbar-width: thin;">
            <c:forEach var="addr" items="${userAddresses}">
                <div class="p-3 border rounded-4 mb-2 bg-light text-dark shadow-sm position-relative animate__animated animate__fadeIn">
                    <small class="fw-bold d-block text-primary">${addr.receiverName}</small>
                    <p class="mb-1 small">${addr.address}</p>
                    <p class="mb-0 x-small text-muted">${addr.city}, ${addr.pincode}</p>
                </div>
            </c:forEach>
            
            <c:if test="${empty userAddresses}">
                <div class="text-center py-3 opacity-50">
                    <small>No addresses saved yet.</small>
                </div>
            </c:if>
        </div>

        <button class="btn btn-sm btn-dark w-100 rounded-pill mt-3 py-2 fw-bold" data-bs-toggle="modal" data-bs-target="#addrModal">
            <i class="fa-solid fa-plus me-1"></i> Add New Address
        </button>
    </div>

    <!-- 3. Profile Info Form -->
    <div class="sk-card p-4 shadow border-0 animate__animated animate__fadeIn" style="animation-delay: 0.2s;">
        <h5 class="fw-bold mb-3"><i class="fa-solid fa-user-pen text-primary me-2"></i> Edit Profile</h5>
        <form action="${pageContext.request.contextPath}/updateProfile" method="post">
            <div class="mb-3">
                <label class="form-label small fw-bold text-muted">Full Name</label>
                <input type="text" name="fullName" class="form-control py-2" value="${user.fullName}" required>
            </div>
            <div class="mb-4">
                <label class="form-label small fw-bold text-muted">Mobile Number</label>
                <input type="text" name="mobile" class="form-control py-2" value="${user.mobile}" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 rounded-pill fw-bold py-2 shadow">Update Account Details</button>
        </form>
    </div>
</div>

<!-- Modal for New Address -->
<div class="modal fade" id="addrModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered px-3">
        <div class="modal-content sk-card border-0 shadow-lg">
            <div class="modal-body p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-800 mb-0">New Address</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/saveAddress" method="post">
                    <input type="text" name="receiverName" class="form-control mb-3" placeholder="Receiver's Name" required>
                    <input type="text" name="receiverMobile" class="form-control mb-3" placeholder="Mobile Number" required>
                    <textarea name="address" class="form-control mb-3" placeholder="Street Address, Area, Landmark" rows="2" required></textarea>
                    <div class="row g-2">
                        <div class="col-6 mb-3"><input type="text" name="city" class="form-control" placeholder="City" required></div>
                        <div class="col-6 mb-3"><input type="text" name="pincode" class="form-control" placeholder="Pincode" required></div>
                    </div>
                    <button class="btn btn-primary w-100 rounded-pill fw-bold py-2 mt-2">Save Address</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- SCRIPTS FOR WALLET ACTIONS -->
<script>
    function addMoney() {
        let amt = prompt("Bhai, kitne paise add karne hain?", "500");
        if (amt != null && amt > 0) {
            window.location.href = "${pageContext.request.contextPath}/addToWallet?amount=" + amt;
        }
    }

    function withdrawMoney() {
        let balance = ${user.walletBalance};
        let amt = prompt("Bhai, kitne paise nikalne hain?", "100");
        if (amt != null && amt > 0) {
            if(amt > balance) {
                alert("Itne paise nahi hain wallet mein!");
            } else {
                window.location.href = "${pageContext.request.contextPath}/withdrawFromWallet?amount=" + amt;
            }
        }
    }
</script>

<style>
    .fw-800 { font-weight: 800; }
    .x-small { font-size: 11px; }
    
    /* Dark Mode internal element visibility */
    .dark-theme .bg-light { 
        background: rgba(255, 255, 255, 0.05) !important; 
        color: white !important; 
        border: 1px solid rgba(255,255,255,0.1) !important; 
    }

    /* Modal Mobile Fix */
    @media (max-width: 576px) {
        .modal-dialog { margin: 0.5rem auto; }
        .p-4 { padding: 1.5rem !important; }
        .display-5 { font-size: 2.5rem; }
    }
</style>
</body>
</html>