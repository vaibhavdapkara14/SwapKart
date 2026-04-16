<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-5">
    <div class="row g-4">
        <!-- Address Form -->
        <div class="col-md-7">
            <div class="sk-card p-4 shadow-lg animate__animated animate__fadeIn">
                <h3 class="fw-bold mb-4">🏠 Delivery Details</h3>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Receiver's Name</label>
                    <input type="text" id="inName" class="form-control" value="${user.fullName}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Mobile Number</label>
                    <input type="text" id="inMobile" class="form-control" value="${user.mobile}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Address Line</label>
                    <textarea class="form-control" id="inAddr" rows="3" placeholder="House no, Area, Landmark..." required></textarea>
                </div>
                <div class="row">
                    <div class="col-6 mb-3"><input type="text" id="inCity" class="form-control" placeholder="City" required></div>
                    <div class="col-6 mb-3"><input type="text" id="inPin" class="form-control" placeholder="Pincode" required></div>
                </div>
                <input type="text" id="inState" class="form-control" placeholder="State" required>
            </div>
        </div>

        <!-- Summary & Razorpay Trigger -->
        <div class="col-md-5">
            <div class="sk-card p-4 text-center d-flex flex-column justify-content-center h-100 shadow-sm border-2">
                <h5 class="text-muted">Payable Amount</h5>
                <h1 class="text-success fw-800 mb-4">₹ ${totalPrice}</h1>
                <hr>
                <button type="button" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold py-3 shadow" onclick="payNow()">
                    Confirm Address & Pay <i class="fa-solid fa-credit-card ms-2"></i>
                </button>
            </div>
        </div>
    </div>
</div>

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
            alert("Bhai, shipping address toh bhariye!");
            return;
        }
        var options = {
                "key": "rzp_test_SAdQv5lvDKIHFl", // Aapki Key ID
                "amount": "${totalPrice * 100}", 
                "currency": "INR",
                "name": "SwapKart",
                "description": "Secure Marketplace Payment",
                "image": "https://cdn-icons-png.flaticon.com/512/599/599305.png", // Aapka logo
                "handler": function (response) {
                    
                    // --- DEPLOYMENT SAFE REDIRECT LOGIC ---
                    // Browser ko batane ke liye ki redirection kahan karni hai
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
            
            // Payment fail handler
            rzp1.on('payment.failed', function (response){
                alert("Payment Failed: " + response.error.description);
            });

            rzp1.open();
        }
    </script>
    </body>
    </html>