
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>
        Details of Order ID: ${order.orderId}
    </title>
    <jsp:include page="/import.jsp"/>
    <link href="/css/global.css" rel="stylesheet" type="text/css">
    <link href="/css/full_height_scroll.css" rel="stylesheet" type="text/css">
    <link href="/css/icon.css" rel="stylesheet" type="text/css">
    <fmt:setLocale value="en_US"/>
</head>
<body>
<c:if test="${message != null}">
    <jsp:include page="/components/toast.jsp"/>
</c:if>
<jsp:include page="/components/modal.jsp"/>
<jsp:include page="/admin/header.jsp"/>
<div class="container-fluid p-0">
    <div class="row">
        <jsp:include page="/admin/sidebar.jsp"/>
        <div class="col-10 offset-2">
            <div class="row m-1">
                <h2 class="text-center">Order #${order.orderId}</h2>
            </div>
            <div class="row m-1">
                <div class="col-3 px-0">
                    <div class="card shadow bg-white rounded">
                        <h4 class="px-2">Order Overview:</h4>
                        <table class="table table-borderless w-100">
                            <tr>
                                <td class=text-secondary" style="width: 180px"><b>Ordered by</b></td>
                                <td>${order.customerByCustomerId.fullName}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Order Status</b></td>
                                <td>${order.status}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Order Date</b></td>
                                <td>${order.orderDate}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Payment Method</b></td>
                                <td>${order.paymentMethod}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Book Copies</b></td>
                                <td>${order.bookCopies}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Total Amount</b></td>
                                <td><fmt:formatNumber value="${order.total}" type="currency"/></td>
                            </tr>
                        </table>
                        <h4 class="px-2">Recipient Information:</h4>
                        <table class="table table-borderless w-100">
                            <tr>
                                <td class=text-secondary" style="width: 180px"><b>First Name</b></td>
                                <td>${order.rFirstname}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Last Name</b></td>
                                <td>${order.rLastname}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Phone</b></td>
                                <td>${order.rPhone}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Address Line 1</b></td>
                                <td>${order.rAddressLine1}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Address Line 2</b></td>
                                <td>${order.rAddressLine2}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>City</b></td>
                                <td>${order.rCity}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>State</b></td>
                                <td>${order.rState}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Zipcode</b></td>
                                <td>${order.rZipcode}</td>
                            </tr>
                            <tr>
                                <td class="text-secondary" style="width: 180px"><b>Country</b></td>
                                <td>${order.countryName}</td>
                            </tr>
                        </table>
                    </div>
                    <div class="my-4 d-flex justify-content-around">
                        <a href="/admin/edit_order?id=${order.orderId}">
                            <button type="submit" class="btn btn-primary"><i class="far fa-edit"></i> Edit this order</button>
                        </a>
                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal"
                                onclick="deleteOrder(${order.orderId}, '')" data-target="#exampleModal">
                            <i class="far fa-trash-alt"></i>
                            Delete this order
                        </button>
                    </div>
                </div>
                <div class="col-9">
                    <div class="card shadow p-0 mb-5 bg-white rounded">
                        <div class="full-height">
                            <div class="full-height-scroll">
                                <table class="table table-sm w-100" style="position: relative;">
                                    <thead>
                                    <tr>
                                        <th scope="col" class="sticky-header">#</th>
                                        <th scope="col" class="sticky-header">Book Title</th>
                                        <th scope="col" class="sticky-header">Author</th>
                                        <th scope="col" class="sticky-header">Price</th>
                                        <th scope="col" class="sticky-header">Quantity</th>
                                        <th scope="col" class="sticky-header text-right">Subtotal</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="orderDetail" varStatus="status" items="${order.orderDetailsByOrderId}">
                                        <tr>
                                            <th scope="row">${status.index + 1}</th>
                                            <th class="d-flex">
                                                <div>
                                                    <img src="data:image/jpg;base64,${orderDetail.bookByBookId.base64Image}"
                                                         style="height: 84px;width: auto;"/>
                                                </div>
                                                <div class="mx-2">
                                                        ${orderDetail.bookByBookId.title}
                                                </div>
                                            </th>
                                            <th>${orderDetail.bookByBookId.author}</th>
                                            <th><fmt:formatNumber value="${orderDetail.bookByBookId.price}" type="currency"/></th>
                                            <th>${orderDetail.quantity}</th>
                                            <th class="text-right"><fmt:formatNumber value="${orderDetail.subtotal}" type="currency"/></th>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th scope="col" class="sticky-header" colspan="5"></th>
                                            <th scope="col" class="sticky-header text-right">
                                                Subtotal:<fmt:formatNumber value="${order.subtotal}" type="currency"/><br>
                                                Tax:<fmt:formatNumber value="${order.tax}" type="currency"/><br>
                                                Shipping Fee:<fmt:formatNumber value="${order.shippingFee}" type="currency"/><br>
                                                TOTAL: <fmt:formatNumber value="${order.total}" type="currency"/><br>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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