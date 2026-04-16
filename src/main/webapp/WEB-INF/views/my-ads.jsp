<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="page" value="myads"/>
</jsp:include>

<html>
<head>

<link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/11440/11440263.png">
<title>My Ads - SwapKart</title>

<style>

    body {
        background: #f8fafc;
        font-family: 'Inter', sans-serif;
    }

    .page-wrapper {
        width: 90%;
        max-width: 1100px;
        margin: 40px auto;
    }

    .title {
        font-size: 32px;
        font-weight: 800;
        color: var(--primary-color);
        margin-bottom: 25px;
    }

    /* Table Card */
    .table-wrapper {
        background: #fff;
        padding: 25px;
        border-radius: 16px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
    }

    th {
        background: #f1f5f9;
        padding: 12px;
        text-align: left;
        font-weight: 700;
        border-bottom: 2px solid #e2e8f0;
    }

    td {
        padding: 14px;
        border-bottom: 1px solid #e2e8f0;
        vertical-align: middle;
    }

    tr:hover td {
        background: #f9fafb;
    }

    .thumb {
        width: 60px;
        height: 60px;
        border-radius: 10px;
        object-fit: cover;
        box-shadow: 0 4px 7px rgba(0,0,0,0.1);
    }

    /* Status Badge */
    .badge {
        padding: 6px 12px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 13px;
    }

    .available {
        background: #dcfce7;
        color: #166534;
    }

    .sold {
        background: #fee2e2;
        color: #b91c1c;
    }

    /* Action Buttons */
    .action-btn {
        text-decoration: none;
        font-weight: 600;
        padding: 8px 14px;
        border-radius: 10px;
        transition: 0.2s;
        margin-right: 10px;
        display: inline-block;
    }

    .toggle-btn {
        background: var(--primary-color);
        color: white;
    }
    .toggle-btn:hover {
        background: #4338ca;
    }

    .delete-btn {
        background: #ef4444;
        color: white;
    }
    .delete-btn:hover {
        background: #dc2626;
    }

</style>
</head>

<body class="${sessionScope.theme == 'dark' ? 'dark-theme' : ''}">

<div class="page-wrapper">

    <div class="title">📦 My Ads</div>

    <div class="table-wrapper">

        <table>
            <tr>
                <th>Image</th>
                <th>Title</th>
                <th>Price</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <c:forEach var="p" items="${list}">
                <tr>
                    <td>
                        <img src="${pageContext.request.contextPath}/assets/img/${p.image}" class="thumb">
                    </td>

                    <td>${p.title}</td>

                    <td><b>₹ ${p.price}</b></td>

                    <td>
                        <span class="badge ${p.status=='Available' ? 'available' : 'sold'}">
                            ${p.status}
                        </span>
                    </td>

                    <td>
                        <a class="action-btn toggle-btn"
                           href="updateStatus?id=${p.id}&status=${p.status=='Available'?'Sold':'Available'}">
                           ${p.status=='Available'?'Mark as Sold':'Mark Available'}
                        </a>

                        <a class="action-btn delete-btn"
                           href="deleteProduct?id=${p.id}">
                           Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>

        </table>

    </div>

</div>

</body>
</html>
