
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Reviews</title>
    <jsp:include page="/import.jsp"/>
    <link href="/css/global.css" rel="stylesheet" type="text/css">
    <link href="/css/full_height_scroll.css" rel="stylesheet" type="text/css">
    <link href="/css/icon.css" rel="stylesheet" type="text/css">
</head>
<body>
<c:if test="${message != null}">
    <jsp:include page="/components/toast.jsp"/>
</c:if>
<jsp:include page="/components/modal.jsp"/>
<jsp:include page="/admin/header.jsp"/>

<div class="row">
    <jsp:include page="/admin/sidebar.jsp"/>
    <div class="col-10 offset-2">
        <div class="row m-1">
            <h2>Manage Reviews</h2>
        </div>

        <div class="row px-4">
            <div class="card shadow p-0 mb-5 bg-white rounded">
                <div class="full-height">
                    <div class="full-height-scroll">
                        <table class="table table-sm" style="position: relative; width: 1200px">
                            <thead>
                            <tr>
                                <th scope="col" class="sticky-header">#</th>
                                <th scope="col" class="sticky-header">Id</th>
                                <th scope="col" class="sticky-header">Ordered by</th>
                                <th scope="col" class="sticky-header">Book Copies</th>
                                <th scope="col" class="sticky-header">Total</th>
                                <th scope="col" class="sticky-header">Payment Method</th>
                                <th scope="col" class="sticky-header">Status</th>
                                <th scope="col" class="sticky-header">Order Date</th>
                                <th scope="col" class="sticky-header" style="align-content: end">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" varStatus="status" items="${ordersList}">
                                <tr>
                                    <th scope="row">${status.index + 1}</th>
                                    <th>${order.orderId}</th>
                                    <th>${order.customerByCustomerId.fullName}</th>
                                    <th>${order.bookCopies}</th>
                                    <th>${order.total}</th>
                                    <th>${order.paymentMethod}</th>
                                    <th>${order.status}</th>
                                    <th>${order.orderDate}</th>

                                    <th>
                                        <a href="/admin/view_order?id=${order.orderId}">
                                            <button type="button"  class="btn btn-primary btn-sm">View <i class="fas fa-search"></i></button>
                                        </a>
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal"
                                                onclick="deleteOrder(${order.orderId}, '')" data-target="#exampleModal">
                                            Delete
                                            <i class="far fa-trash-alt"></i>
                                        </button>
                                    </th>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row px-4">
            <ul class="pagination">
                <c:if test="${page != 1}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/list_orders?page=${page - 1}">Previous</a>
                    </li>
                </c:if>
                <c:forEach var="i" begin="1" end="${numOfPages}">
                    <c:if test="${page == i}">
                        <li class="page-item active">
                            <a class="page-link" href="/admin/list_orders?page=${i}">${i}</a>
                        </li>
                    </c:if>
                    <c:if test="${page != i}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/list_orders?page=${i}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${page != numOfPages && numOfPages != 0}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/list_orders?page=${page + 1}">Next</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript">
    function deleteOrder(id, name) {
        document.getElementById("url").action = "/admin/delete_order"

        const orderId = document.getElementById("id")
        orderId.value = id
        orderId.name= "orderId"
        const title = document.getElementsByClassName("modal-title")[0]
        title.innerText = "Delete order #" + id;
        const body = document.getElementsByClassName("modal-body")[0]
        body.innerText="Do you want to delete this order?";
    }
</script>
</body>
</html>