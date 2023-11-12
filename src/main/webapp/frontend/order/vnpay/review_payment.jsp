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
                <h4 class="text-capitalize">Recipient Information</h4>
                <div class="details recipient-info">
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Full Name:</p>
                        <p class="col-7 m-0">${order4VNPay.rFirstname} ${order4VNPay.rLastname}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Address Line 1:</p>
                        <p class="col-7 m-0">${order4VNPay.rAddressLine1}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Address Line 2:</p>
                        <p class="col-7 m-0">${order4VNPay.rAddressLine2}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">City:</p>
                        <p class="col-7 m-0">${order4VNPay.rCity}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">State:</p>
                        <p class="col-7 m-0">${order4VNPay.rState}</p>
                    </div>
                    <div class="row align-items-center pb-3">
                        <p class="font-weight-bold col-5 m-0">Country Code:</p>
                        <p class="col-7 m-0">${order4VNPay.rCountry}</p>
                    </div>
                    <div class="row align-items-center">
                        <p class="font-weight-bold col-5 m-0">Postal Code:</p>
                        <p class="col-7 m-0">${order4VNPay.rZipcode}</p>
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
                        <p class="col-7 m-0">Order on Maple BookStore</p>
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
                            <c:forEach  items="${order4VNPay.orderDetailsByOrderId}" var="item" varStatus="status">
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
                                    Subtotal: <fmt:formatNumber value="${order4VNPay.subtotal}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right">
                                    Tax: <fmt:formatNumber value="${order4VNPay.tax}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right">
                                    Shipping Fee: <fmt:formatNumber value="${order4VNPay.shippingFee}" type="currency" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-right font-weight-bold">
                                    TOTAL: <fmt:formatNumber value="${order4VNPay.total}" type="currency" />
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row align-items-center justify-content-center pb-3">
            <form action="/ajaxServlet" method="post" class="justify-content-center px-4" id="frmCreateOrder">
                <input type="hidden" name="ordertype" value="book">
                <input type="hidden" name="amount" value="10000">
                <input type="hidden" name="vnp_OrderInfo" value="Thanh toan don hang">
                <input type="hidden" name="bankcode" value="">
                <input type="hidden" name="language" value="en">
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
<script type="text/javascript">
    $("#frmCreateOrder").submit(function () {
        var postData = $("#frmCreateOrder").serialize();
        var submitUrl = $("#frmCreateOrder").attr("action");
        $.ajax({
            type: "POST",
            url: submitUrl,
            data: postData,
            dataType: 'JSON',
            success: function (x) {
                if (x.code === '00') {
                    if (window.vnpay) {
                        vnpay.open({width: 768, height: 600, url: x.data});
                    } else {
                        location.href = x.data;
                    }
                    return false;
                } else {
                    alert(x.Message);
                }
            }
        });
        return false;
    });
</script>

</body>
</html>