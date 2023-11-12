<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">

<head>

    <title>Review your payment</title>


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
                Please carefully review the following informaition before making payment
            </i>
        </div>
        <div class="row">
            <div class="col-md-12 p-3 d-flex flex-column align-items-center justify-content-center">
                <h4 class="text-capitalize">Payer Informaition</h4>
                <div class="details payer-info">
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">First Name:</p>
                        <p class="col-7 m-0">${payerInfo.firstName}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Last Name:</p>
                        <p class="col-7 m-0">${payerInfo.lastName}</p>
                    </div>
                    <div class="row align-items-center">
                        <p class="font-weight-bold col-5 m-0">E-mail:</p>
                        <p class="col-7 m-0">${payerInfo.email}</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 p-3 d-flex flex-column align-items-center justify-content-center">
                <h4 class="text-capitalize">Recipient Information</h4>
                <div class="details recipient-info">
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Full Name:</p>
                        <p class="col-7 m-0">${shippingAddress.recipientName}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Address Line 1:</p>
                        <p class="col-7 m-0">${shippingAddress.line1}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Address Line 2:</p>
                        <p class="col-7 m-0">${shippingAddress.line2}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">City:</p>
                        <p class="col-7 m-0">${shippingAddress.city}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">State:</p>
                        <p class="col-7 m-0">${shippingAddress.state}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Country Code:</p>
                        <p class="col-7 m-0">${shippingAddress.countryCode}</p>
                    </div>
                    <div class="row align-items-center">
                        <p class="font-weight-bold col-5 m-0">Postal Code:</p>
                        <p class="col-7 m-0">${shippingAddress.postalCode}</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 p-3 d-flex flex-column align-items-center justify-content-center">
                <h4 class="text-capitalize">Transaction Details</h4>
                <div class="details transaction-info">
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Description:</p>
                        <p class="col-7 m-0">${transaction.description}</p>
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
                            <c:forEach  items="${transaction.itemList.items}" var="item" varStatus="status">
                                <tr>
                                    <th scope="row">${status.index + 1}</th>
                                    <td>${item.name}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price}" type="currency" /></td>
                                    <td class="text-right"><fmt:formatNumber value="${item.price * item.quantity}" type="currency" /></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot class="table-borderless">
                            <tr>
                                <td colspan="5" class="text-right">
                                    Subtotal: <fmt:formatNumber value="${transaction.amount.details.subtotal}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right">
                                    Tax: <fmt:formatNumber value="${transaction.amount.details.tax}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right">
                                    Shipping Fee: <fmt:formatNumber value="${transaction.amount.details.shipping}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right font-weight-bold">
                                    TOTAL: <fmt:formatNumber value="${transaction.amount.total}" type="currency" />
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row align-items-center justify-content-center pb-3">
            <form action="/execute_payment" method="post" class="justify-content-center px-4">
                <input type="hidden" name="paymentId" value="${param.paymentId}" />
                <input type="hidden" name="PayerID" value="${param.PayerID}" />
                <button type="submit" class="btn btn-danger">Pay Now</button>
                <a href="/checkout">
                    <button type="button" class="btn btn-outline-danger mr-4">Back To Checkout</button>
                </a>
            </form>
        </div>
    </div>
</div>

<%@include file="/components/Footer.jsp"%>
<jsp:include page="/importLib.jsp"/>


</body>
</html>