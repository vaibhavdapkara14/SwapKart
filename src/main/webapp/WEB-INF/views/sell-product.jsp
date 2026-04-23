<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<!-- Zaroori Meta Tag for Mobile -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">
<div class="container py-4 py-md-5">
    <!-- Responsive Card: 100% width on mobile, 850px on desktop -->
    <div class="sk-card p-3 p-md-5 mx-auto shadow-lg animate__animated animate__fadeInUp" style="max-width: 850px; width: 100%;">
        
        <div class="text-center mb-4">
            <h2 class="fw-800 mb-1" style="font-size: clamp(1.5rem, 5vw, 2.2rem);">Post Your Ad 🔥</h2>
            <p class="text-muted small">Choose a category to provide specific details.</p>
        </div>

        <form action="${pageContext.request.contextPath}/sellProduct" method="post" enctype="multipart/form-data">
            
            <div class="row g-3">
                <!-- Main Category - Responsive Column -->
                <div class="col-12 col-md-6 mb-2">
                    <label class="form-label fw-bold">Category</label>
                    <select name="category" id="catSelect" class="form-select border-2 py-2" onchange="updateFields()" required>
                        <option value="" disabled selected>-- Select --</option>
                        <option value="Mobile">Mobile Phones</option>
                        <option value="Laptops">Laptops & PCs</option>
                        <option value="Vehicles">Bikes & Cars</option>
                        <option value="Appliances">Home Appliances</option>
                        <option value="Furniture">Furniture</option>
                        <option value="Fashion">Fashion & Shoes</option>
                        <option value="Gaming">Gaming & Consoles</option>
                        <option value="Pets">Pets</option>
                        <option value="RealEstate">Real Estate</option>
                        <option value="Others">Others</option>
                    </select>
                </div>
                <!-- Title - Responsive Column -->
                <div class="col-12 col-md-6 mb-2">
                    <label class="form-label fw-bold">Ad Title</label>
                    <input type="text" name="title" class="form-control border-2 py-2" placeholder="e.g. Samsung S23 Ultra" required>
                </div>
            </div>

            <!-- DYNAMIC SPECIFICATIONS BLOCK (Responsive via JS) -->
            <div id="dynamicSpecs" class="p-3 rounded-4 mb-4 mt-3 d-none" style="background: rgba(99,102,241,0.08); border: 1.5px dashed #6366f1;">
                <h6 class="fw-bold mb-3 text-primary"><i class="fa-solid fa-list-check me-2"></i> Additional Details</h6>
                <div id="fieldsContainer" class="row g-3">
                    <!-- JavaScript will inject col-12 col-md-6 classes here -->
                </div>
            </div>

            <div class="mb-3 mt-2">
                <label class="form-label fw-bold">Set Price (₹)</label>
                <div class="input-group">
                    <span class="input-group-text bg-light fw-bold text-success border-2">₹</span>
                    <input type="number" name="price" class="form-control form-control-lg fw-bold text-success border-2" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Description</label>
                <textarea name="description" class="form-control border-2" rows="3" placeholder="Condition, usage, warranty etc." required></textarea>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">Upload Image</label>
                <input type="file" name="image" class="form-control border-2" accept="image/*" required>
            </div>

            <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill fw-800 shadow-lg py-2 py-md-3">
                SUBMIT LISTING 🚀
            </button>
        </form>
    </div>
</div>

<script>
function updateFields() {
    const cat = document.getElementById("catSelect").value;
    const container = document.getElementById("fieldsContainer");
    const outerBox = document.getElementById("dynamicSpecs");
    
    outerBox.classList.remove('d-none');
    container.innerHTML = ""; 

    let fields = "";
    
    // Note: Har field mein col-12 (mobile) aur col-md-X (desktop) grid classes lagayi hain
    if(cat === "Mobile") {
        fields = `<div class="col-12 col-md-6"><label class="small fw-bold">Brand</label><input type="text" name="brand" class="form-control" placeholder="Apple, Samsung"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">RAM (GB)</label><input type="number" name="ram" class="form-control"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Storage</label><input type="text" name="storage" class="form-control" placeholder="128GB, 256GB"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Model</label><input type="text" name="model" class="form-control"></div>`;
    } 
    else if(cat === "Vehicles") {
        fields = `<div class="col-12 col-md-4"><label class="small fw-bold">Year</label><input type="number" name="year" class="form-control" placeholder="2022"></div>
                  <div class="col-12 col-md-4"><label class="small fw-bold">KM Driven</label><input type="number" name="km" class="form-control"></div>
                  <div class="col-12 col-md-4"><label class="small fw-bold">Fuel Type</label><select name="fuel" class="form-select"><option>Petrol</option><option>Electric</option><option>Diesel</option></select></div>
                  <div class="col-12"><label class="small fw-bold">Ownership</label><select name="owner" class="form-select"><option>1st Owner</option><option>2nd Owner</option></select></div>`;
    }
    else if(cat === "Laptops") {
        fields = `<div class="col-12 col-md-4"><label class="small fw-bold">Processor</label><input type="text" name="processor" class="form-control" placeholder="i5, M2"></div>
                  <div class="col-12 col-md-4"><label class="small fw-bold">RAM (GB)</label><input type="number" name="ram" class="form-control"></div>
                  <div class="col-12 col-md-4"><label class="small fw-bold">SSD/HDD</label><input type="text" name="storage" class="form-control"></div>`;
    }
    else if(cat === "Fashion") {
        fields = `<div class="col-12 col-md-6"><label class="small fw-bold">Size</label><input type="text" name="size" class="form-control" placeholder="XL, 42, 10"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Material</label><input type="text" name="material" class="form-control"></div>`;
    }
    else if(cat === "Pets") {
        fields = `<div class="col-12 col-md-6"><label class="small fw-bold">Breed</label><input type="text" name="breed" class="form-control"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Age</label><input type="text" name="age" class="form-control"></div>`;
    }
    else if(cat === "Furniture") {
        fields = `<div class="col-12 col-md-6"><label class="small fw-bold">Wood Type</label><input type="text" name="material" class="form-control"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Condition</label><select name="cond" class="form-select"><option>New</option><option>Used</option></select></div>`;
    }
    else if(cat === "RealEstate") {
        fields = `<div class="col-12 col-md-6"><label class="small fw-bold">Area (Sqft)</label><input type="number" name="sqft" class="form-control"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Type</label><select name="type" class="form-select"><option>1 BHK</option><option>2 BHK</option><option>Plot</option></select></div>`;
    }
    else if(cat === "Appliances" || cat === "Electronics") {
        fields = `<div class="col-12 col-md-6"><label class="small fw-bold">Brand</label><input type="text" name="brand" class="form-control"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Warranty</label><select name="war" class="form-select"><option>Yes</option><option>No</option></select></div>`;
    }
    else if(cat === "Gaming") {
        fields = `<div class="col-12 col-md-6"><label class="small fw-bold">Console Name</label><input type="text" name="console" class="form-control" placeholder="PS5, Xbox"></div>
                  <div class="col-12 col-md-6"><label class="small fw-bold">Games Included</label><input type="number" name="games" class="form-control"></div>`;
    }
    else {
        outerBox.classList.add('d-none');
    }

    container.innerHTML = fields;
}
</script>

<style>
    .fw-800 { font-weight: 800; }
    .form-control:focus, .form-select:focus { border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2); }
    
    /* Screen adjustments for mobile phones */
    @media (max-width: 576px) {
        .container { padding-left: 10px; padding-right: 10px; }
        .sk-card { padding: 25px 15px !important; border-radius: 20px !important; }
    }
    
    /* Ensure select options look good in Dark Mode */
    select option { background: #0f172a; color: white; }
</style>
</body>
</html>