<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- 1. Mobile Meta Tag (Zaroori) -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-4 py-md-5">
    <div class="row g-4">
        
        <!-- LEFT SIDE: Address Form (Responsive col-12) -->
        <div class="col-12 col-lg-7">
            <div class="sk-card p-3 p-md-4 shadow-lg animate__animated animate__fadeIn">
                <h3 class="fw-bold mb-4" style="font-size: clamp(1.2rem, 4vw, 1.8rem);">
                    <i class="fa-solid fa-truck-fast text-primary me-2"></i> Delivery Details
                </h3>
                
                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Receiver's Name</label>
                    <input type="text" id="inName" class="form-control py-2" value="${user.fullName}" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Mobile Number</label>
                    <input type="text" id="inMobile" class="form-control py-2" value="${user.mobile}" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Street Address / House No.</label>
                    <textarea class="form-control" id="inAddr" rows="3" placeholder="Flat No, Building, Landmark..." required></textarea>
                </div>
                
                <div class="row g-3">
                    <div class="col-12 col-sm-6">
                        <label class="form-label small fw-bold text-muted">City</label>
                        <input type="text" id="inCity" class="form-control py-2" placeholder="Indore" required>
                    </div>
                    <div class="col-12 col-sm-6">
                        <label class="form-label small fw-bold text-muted">Pincode</label>
                        <input type="text" id="inPin" class="form-control py-2" placeholder="452001" required>
                    </div>
                </div>
                
                <div class="mt-3">
                    <label class="form-label small fw-bold text-muted">State</label>
                    <input type="text" id="inState" class="form-control py-2" placeholder="e.g. Madhya Pradesh" required>
                </div>
            </div>
        </div>

        <!-- RIGHT SIDE: Summary & Razorpay (Responsive col-12) -->
        <div class="col-12 col-lg-5">
            <div class="sk-card p-4 text-center d-flex flex-column justify-content-center shadow-sm border-2 h-100">
                <h5 class="text-muted mb-3 fw-bold small">ORDER SUMMARY</h5>
                <p class="mb-1 opacity-75">Payable Amount</p>
                <h1 class="text-success fw-800 mb-4" style="font-size: clamp(2rem, 8vw, 3rem);">₹ ${totalPrice}</h1>
                <hr class="opacity-25">
                <button type="button" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold py-3 shadow-lg animate__animated animate__pulse animate__infinite" onclick="payNow()">
                    Confirm & Pay Now <i class="fa-solid fa-credit-card ms-2"></i>
                </button>
                <p class="mt-3 small text-muted">
                    <i class="fa-solid fa-shield-halved"></i> 100% Secure Transaction
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Razorpay Integration Script -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
    function payNow() {
        let name = document.getElementById("inName").value;
        let mobile = document.getElementById("inMobile").value;
        let address = document.getElementById("inAddr").value;
        let city = document.getElementById("inCity").value;
        let pin = document.getElementById("inPin").value;
        let state = document.getElementById("inState").value;

        if(!name || !address || !city || !pin) {
            alert("Bhai, saari delivery details toh bharo!");
            return;
        }

        var options = {
            "key": "rzp_test_SAdQv5lvDKIHFl", 
            "amount": "${totalPrice * 100}", 
            "currency": "INR",
            "name": "SwapKart",
            "description": "Secure Marketplace Payment",
            "image": "https://cdn-icons-png.flaticon.com/512/599/599305.png",
            "handler": function (response) {
                
                const contextPath = "${pageContext.request.contextPath}";
                const successPage = contextPath + "/paymentSuccess";
                
                const finalURL = successPage 
                                + "?pay_id=" + response.razorpay_payment_id
                                + "&name=" + encodeURIComponent(name)
                                + "&mobile=" + encodeURIComponent(mobile)
                                + "&address=" + encodeURIComponent(address)
                                + "&city=" + encodeURIComponent(city)
                                + "&state=" + encodeURIComponent(state)
                                + "&pincode=" + encodeURIComponent(pin);
                
                window.location.href = finalURL;
            },
            "prefill": {
                "name": "${user.fullName}",
                "email": "${user.email}",
                "contact": "${user.mobile}"
            },
            "theme": {
                "color": "#6366f1"
            }
        };
        
        var rzp1 = new Razorpay(options);
        
        rzp1.on('payment.failed', function (response){
            alert("Payment Failed: " + response.error.description);
        });

        rzp1.open();
    }
</script>

<style>
    .fw-800 { font-weight: 800; }
    /* Form Focus Styles */
    .form-control:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
    }
    /* Mobile internal row adjustments */
    @media (max-width: 768px) {
        .container { padding-left: 15px; padding-right: 15px; }
        .sk-card { border-radius: 20px !important; }
    }
</style>
</body>
</html>