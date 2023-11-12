<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">

<head>

    <title>Order#${order.orderId}</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />
    <link rel="stylesheet" href="/css/profile.css">

</head>
<body>
<%@include file="/components/Header.jsp"%>

<div class="container pb-3 d-flex justify-content-center flex-wrap">
    <div class="pb-5 pt-3 col-10">
        <c:if test="${order == null}">
            <h2 class="text-center" style="min-height: 300px">Sorry, you can not authorized to view this order.</h2>
        </c:if>
        <c:if test="${order != null}">
            <h2 class="text-center">Invoice</h2>
            <section class="row mt-5 store-user">
                <div class="col-1"></div>
                <div class="col-10">
                    <div class="row bb pb-3 d-flex justify-content-center">
                        <div class="col-7">
                            <p>Supplier,</p>
                            <h3 class="text-info">Group 06</h3>
                            <p class="address">01 - Vo Van Ngan,
                                <br>Thu Duc, HCM City,
                                <br>Vietnam
                            </p>
                            <div class="phone mt-2">+84 361323695</div>
                        </div>
                        <div class="col-5">
                            <p>Recipient,</p>
                            <h3 class="text-info">${order.rFirstname} ${order.rLastname}</h3>
                            <p class="address">
                                ${order.rAddressLine1}<br>
                                ${order.rAddressLine2},<br>
                                ${order.rState}, ${order.rCity}, ${order.rZipcode},<br>
                                ${order.countryName}
                            </p>
                            <div class="phone mt-2">${order.rPhone}</div>
                        </div>
                    </div>
                    <hr>
                    <div class="row extra-info pt-3">
                        <div class="col-7">
                            <p>Order ID:
                                <span>${order.orderId}</span>
                            </p>
                            <p>Order Date:
                                <span>${order.orderDate}</span>
                            </p>
                            <p>Order Status:
                                <span>${order.status}</span>
                            </p>
                        </div>
                        <div class="col-5">
                            <p>Payment Method:
                                <span>${order.paymentMethod}</span>
                            </p>
                            <p>Quantity:
                                <span>${order.bookCopies}</span>
                            </p>
                            <p>Total Price:
                                <span><fmt:formatNumber value="${order.total}" type="currency" /></span>
                            </p>
                        </div>
                    </div>
                </div>
            </section>
        </c:if>
    </div>
    <c:if test="${order != null}">
        <div class="table-responsive-lg col-10">
            <table class="table table-bordered table-striped table-hover text-center">
                <thead class="thead-dark">
                <tr>
                    <th>No.</th>
                    <th>Book</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="subtotal" value="${0}" scope="page"/>
                <c:forEach items="${order.orderDetailsByOrderId}" var="orderDetail" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td> <!-- / .Product number - auto increase-->
                        <td>
                            <div class="cart-info">
                                <img src="data:image/jpg;base64,${orderDetail.bookByBookId.base64Image}"
                                     alt="${orderDetail.bookByBookId.title}" style="max-height: 100px">
                                <!-- / .Book image-->
                                <p class="m-0 p-2 col-12 text-truncate" style="max-width: 10rem;">
                                        ${orderDetail.bookByBookId.title}
                                </p>
                                <!-- / .Book name-->
                            </div>
                        </td>
                        <td>
                                ${orderDetail.bookByBookId.author}
                        </td>
                        <td>
                            <fmt:formatNumber value="${orderDetail.bookByBookId.price}" type="currency" />
                        </td> <!-- / .Unit price-->
                        <td>
                                ${orderDetail.quantity}
                        </td> <!-- / .Quantity-->
                        <td>
                            <fmt:formatNumber value="${orderDetail.subtotal}" type="currency" />
                            <!-- / .Subtotal-->
                        </td>
                        <c:set var="subtotal" value="${subtotal + orderDetail.subtotal}" scope="page"/>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot>
                <tr>
                    <td class="text-right" colspan="6">
                        Subtotal: <fmt:formatNumber value="${subtotal}" type="currency" /><br>
                        Tax: <fmt:formatNumber value="${order.tax}" type="currency" /><br>
                        Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type="currency" /><br>
                        TOTAL: <fmt:formatNumber value="${order.total}" type="currency" /><br>
                    </td>
                </tr>
                </tfoot>
            </table>
        </div>
    </c:if>
</div>

<%@include file="/components/Footer.jsp"%>
<jsp:include page="/importLib.jsp"/>


</body>
</html>