<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <title>Shopping cart</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />
    <link rel="stylesheet" href="/css/cart_order.css">

</head>

<body>

<%@include file="/components/Header.jsp"%>
<div class="container p-0">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-8 text-center">
                <div class="check-out-header border p-2 mb-1">
                    <h3>Order Details</h3>
                    <!-- <hr> -->
                </div>
                <table class="table table-bordered table-striped table-hover table-responsive-lg">
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
                    <tbody class="text-center">
                    <c:set var="subtotal" value="${0}" scope="page"/>
                    <c:forEach items="${cart.items}" var="item" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td> <!-- / .Product number - auto increase-->
                            <td class="text-left">
                                <div class="cart-info d-flex flex-nowrap">
                                    <img src="data:image/jpg;base64,${item.key.base64Image}" alt="Effective Java">
                                    <!-- / .Book image-->
                                    <p class="m-0 p-2 col-12 text-truncate" style="max-width: 10rem;">
                                            ${item.key.title}
                                    </p>
                                    <!-- / .Book name-->
                                </div>
                            </td>
                            <td>${item.key.author}</td> <!-- / .Author's name-->
                            <td><fmt:formatNumber value="${item.key.price * item.value}" type="currency"/></td> <!-- / .Unit price-->
                            <td>${item.value}</td> <!-- / .Quantity-->
                            <td><fmt:formatNumber value="${item.key.price * item.value}" type="currency"/></td> <!-- / .Subtotal price-->
                            <c:set var="subtotal" value="${subtotal + item.key.price * item.value}" scope="page"/>
                        </tr>
                    </c:forEach>
                    <!-- / .Render cart data -->
                    </tbody>
                    <tfoot class="text-center">
                    <tr>
                        <td class="text-right" colspan="6">
                            Subtotal: <fmt:formatNumber value="${subtotal}" type="currency" /><br>
                            Tax: <fmt:formatNumber value="${tax}" type="currency" /><br>
                            Shipping Fee: <fmt:formatNumber value="${shippingFee}" type="currency" /><br>
                            TOTAL: <fmt:formatNumber value="${total}" type="currency" /><br>
                        </td>
                    </tr>
                    </tfoot>
                </table>
                <div class="row">
                    <div class="col-md-4 col-lg-3 m-auto">
                        <a href="${pageContext.request.contextPath}/view_cart"><button class="btn btn-danger btn-block">Edit Cart</button></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-center py-2 check-out border">
                <h3>Shopping Information</h3>
                <hr>
                <form method="post" action="/place_order">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputFirstname" class="font-italic">First Name</label>
                            <input type="text" class="form-control form-control-custom" id="inputFirstname"
                                   name="rFirstname" value="${loggedCustomer.firstname}" placeholder="First Name...">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="inputLastname" class="font-italic">Last Name</label>
                            <input type="text" class="form-control form-control-custom" id="inputLastname"
                                   name="rLastname" value="${loggedCustomer.lastname}" placeholder="Last Name...">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPhone" class="font-italic">Contact Number</label>
                        <input type="text" class="form-control form-control-custom" id="inputPhone"
                               name="rPhone" value="${loggedCustomer.phone}" placeholder="Phone...">
                    </div>
                    <div class="form-group">
                        <label for="inputAddress1" class="font-italic">Address Line 1</label>
                        <input type="text" class="form-control form-control-custom" id="inputAddress1"
                               name="rAddressLine1" value="${loggedCustomer.addressLine1}" placeholder="Apartment, studio, or floor...">
                    </div>
                    <div class="form-group">
                        <label for="inputAddress2" class="font-italic">Address Line 2</label>
                        <input type="text" class="form-control form-control-custom" id="inputAddress2"
                               name="rAddressLine2" value="${loggedCustomer.addressLine2}" placeholder="Apartment, studio, or floor...">
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputCity" class="font-italic">City</label>
                            <input type="text" class="form-control form-control-custom" id="inputCity"
                                   name="rCity" value="${loggedCustomer.city}" placeholder="City...">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="inputState" class="font-italic">State</label>
                            <input type="text" class="form-control form-control-custom" id="inputState"
                                   name="rState" value="${loggedCustomer.state}" placeholder="State...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputZip" class="font-italic">Zip</label>
                        <input type="text" class="form-control form-control-custom" id="inputZip"
                               name="rZipcode" value="${loggedCustomer.zipcode}" placeholder="Zip code...">
                    </div>
                    <div class="form-group">
                        <select name="rCountry" id="inputCountry"
                                class="form-control form-control-custom font-weight-bold mb-3">
                            <c:forEach items="${mapCountries}" var="country">
                                <option value="${country.value}" class="option-size-custom"
                                        <c:if test="${loggedCustomer.country eq country.value}">selected="selected"</c:if>>
                                        ${country.key}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <hr>
                    <div class="form-group">
                        <h5 class="font-italic">Payment method</h5>
                        <div class="icon-groups-custom border-bottom pb-2 mb-2">
                            <span class="font-italic mr-2">Accepted Cards:</span>
                            <i class="fab fa-cc-visa" style="color: navy"></i>
                            <i class="fab fa-cc-paypal" style="color: darkturquoise"></i>
                            <i class="fab fa-cc-mastercard" style="color: red"></i>
                        </div>
                        <select id="inputPayment" name="paymentMethod"
                                class="form-control form-control-custom font-weight-bold mb-3">
                            <option value="Cash on delivery" class="option-size-custom" selected>Cash on delivery</option>
                            <option value="paypal" class="option-size-custom">PayPal</option>
                            <option value="vnpay" class="option-size-custom">VNPay</option>
                        </select>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-5 pb-2">
                            <button type="submit" class="btn btn-danger btn-block">Order</button>
                        </div>
                        <div class="col-md-6 col-lg-7 pb-2">
                            <a href="${pageContext.request.contextPath}/">
                                <button type="button" class="btn btn-outline-danger btn-block">Continue Shopping</button>
                            </a>

                        </div>
                    </div>
                </form> <!-- / .Render user info to this form-->

            </div>
        </div>
    </div>
</div>
<%@ include file="/importLib.jsp"%>

<c:if test="${message != null}">
    <jsp:include page="/frontend/toast.jsp"/>
</c:if>

<%@include file="/components/Footer.jsp"%>


</body>

</html>