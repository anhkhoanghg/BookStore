<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">

<head>

    <title>Payment #${orderId}</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />
    <link rel="stylesheet" href="/css/order_preview.css">

</head>
<body>
<%@include file="/components/Header.jsp"%>

<div class="container">
    <div class="main">
        <div class="text-center">
            <i class="font-italic text-secondary">
                <h2>
                    You have made payment successfully. Thank you for purchasing!
                </h2>
            </i>
        </div>
        <div class="row">
            <div class="col-md-12 p-3 d-flex flex-column align-items-center justify-content-center">
                <h3 class="text-capitalize">Your payment receipt</h3>
                <h4>Seller information</h4>
                <div class="details seller-info">
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Company Name:</p>
                        <p class="col-7 m-0">Maple Store</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Email:</p>
                        <p class="col-7 m-0">info@bookworm.com</p>
                    </div>
                    <div class="row align-items-center">
                        <p class="font-weight-bold col-5 m-0">Phone:</p>
                        <p class="col-7 m-0">+123456789</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 p-3 d-flex flex-column align-items-center justify-content-center">
                <h4>Buyer information</h4>
                <div class="details buyer-info">
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">First Name:</p>
                        <p class="col-7 m-0">${loggedCustomer.firstname}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Last Name:</p>
                        <p class="col-7 m-0">${loggedCustomer.lastname}</p>
                    </div>
                    <div class="row align-items-center">
                        <p class="font-weight-bold col-5 m-0">E-mail:</p>
                        <p class="col-7 m-0">${loggedCustomer.email}</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 p-3 d-flex flex-column align-items-center justify-content-center">
                <h4 class="text-capitalize">Order Details</h4>
                <div class="details order-info">
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Order Id:</p>
                        <p class="col-7 m-0">${orderId}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Order by:</p>
                        <p class="col-7 m-0">${loggedCustomer.fullName}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Transaction Description:</p>
                        <p class="col-7 m-0">Order on MapleBookStore</p >
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Item list:</p>
                    </div>
                    <div class="row align-items-center table-responsive-lg pr-3 pl-3">
                        <table class="table table-striped table-bordered">
                            <thead class="thead-dark">
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Name</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th scope="col" class="text-right">Subtotal</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach  items="${order.orderDetailsByOrderId}" var="item" varStatus="status">
                                <tr>
                                    <th scope="row">${status.index + 1}</th>
                                    <td>${item.bookByBookId.title}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.bookByBookId.price}" type="currency" /></td>
                                    <td class="text-right"><fmt:formatNumber value="${item.bookByBookId.price * item.quantity}" type="currency" /></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot class="table-borderless">
                            <tr>
                                <td colspan="5" class="text-right">
                                    Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right">
                                    Tax: <fmt:formatNumber value="${order.tax}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right">
                                    Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right font-weight-bold">
                                    TOTAL: <fmt:formatNumber value="${order.total}" type="currency" />
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row align-items-center justify-content-center pb-3">

        </div>
    </div>
</div>

<%@include file="/components/Footer.jsp"%>
<jsp:include page="/importLib.jsp"/>


</body>
</html>