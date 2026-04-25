<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="page" value="myads"/>
</jsp:include>

<!-- Mobile Viewport -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<html>
<head>
<link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
<title>My Ads - SwapKart</title>

<style>
    body {
        background: var(--bg-main);
        font-family: 'Inter', sans-serif;
        transition: 0.3s;
    }

    .page-wrapper {
        width: 95%;
        max-width: 1100px;
        margin: 20px auto;
    }

    .title {
        font-size: clamp(1.5rem, 5vw, 2rem);
        font-weight: 800;
        color: #6366f1; /* Professional Indigo */
        margin-bottom: 25px;
    }

    /* Table Card Responsive */
    .table-wrapper {
        background: var(--card-bg);
        padding: 15px;
        border-radius: 16px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        border: 1px solid var(--border);
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }

    th {
        background: rgba(99, 102, 241, 0.05);
        padding: 12px;
        text-align: left;
        font-weight: 700;
        border-bottom: 2px solid var(--border);
        white-space: nowrap;
    }

    td {
        padding: 12px;
        border-bottom: 1px solid var(--border);
        vertical-align: middle;
        color: var(--text-main);
    }

    tr:hover td {
        background: rgba(99, 102, 241, 0.02);
    }

    .thumb {
        width: 50px;
        height: 50px;
        border-radius: 8px;
        object-fit: cover;
        box-shadow: 0 4px 7px rgba(0,0,0,0.1);
        border: 1px solid var(--border);
    }

    /* Status Badge */
    .badge-sk {
        padding: 5px 12px;
        border-radius: 50px;
        font-weight: 700;
        font-size: 11px;
        text-transform: uppercase;
    }

    .available { background: #dcfce7; color: #166534; }
    .sold { background: #fee2e2; color: #b91c1c; }

    /* Action Buttons */
    .action-btn {
        text-decoration: none;
        font-weight: 700;
        padding: 6px 12px;
        border-radius: 8px;
        transition: 0.2s;
        display: inline-block;
        font-size: 12px;
        margin: 2px;
        white-space: nowrap;
    }

    .toggle-btn { background: #6366f1; color: white !important; }
    .toggle-btn:hover { background: #4f46e5; transform: translateY(-1px); }

    .delete-btn { background: #ef4444; color: white !important; }
    .delete-btn:hover { background: #dc2626; transform: translateY(-1px); }

    /* Mobile specific tweaks */
    @media (max-width: 768px) {
        .page-wrapper { margin: 10px auto; }
        .table-wrapper { padding: 10px; border-radius: 12px; }
        td, th { padding: 10px 8px; }
        .thumb { width: 40px; height: 40px; }
    }
</style>
</head>

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<div class="page-wrapper">

    <div class="title animate__animated animate__fadeInLeft">
        <i class="fa-solid fa-boxes-stacked me-2"></i> My Listings
    </div>

    <div class="table-wrapper animate__animated animate__fadeInUp">
        
        <!-- Table Responsive Container -->
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="p" items="${list}">
                        <tr>
                            <td>
                                <!-- RENDER/CLOUDINARY FIX: Direct URL -->
                                <img src="${p.image}" 
                                     onerror="this.src='https://placehold.co/100x100?text=Item'" 
                                     class="thumb">
                            </td>

                            <td class="fw-bold">${p.title}</td>

                            <td class="text-nowrap text-success fw-bold">₹ ${p.price}</td>

                            <td>
                                <span class="badge-sk ${p.status=='Available' ? 'available' : 'sold'}">
                                    ${p.status}
                                </span>
                            </td>

                            <td>
                                <div class="d-flex flex-wrap">
                                    <a class="action-btn toggle-btn shadow-sm"
                                       href="${pageContext.request.contextPath}/updateStatus?id=${p.id}&status=${p.status=='Available'?'Sold':'Available'}">
                                       <i class="fa-solid fa-rotate me-1"></i>
                                       ${p.status=='Available'?'Sold':'Available'}
                                    </a>

                                    <a class="action-btn delete-btn shadow-sm"
                                       href="${pageContext.request.contextPath}/deleteProduct?id=${p.id}"
                                       onclick="return confirm('Are You sure ? ')">
                                       <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-folder-open fa-3x mb-3 opacity-25"></i><br>
                                No listed item Availabe !
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>

</div>

</body>
</html>