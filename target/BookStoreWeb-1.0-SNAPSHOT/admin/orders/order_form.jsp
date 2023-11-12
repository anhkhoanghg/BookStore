
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
<jsp:include page="/admin/header.jsp"/>
<div class="container-fluid p-0">
    <div class="row">
        <jsp:include page="/admin/sidebar.jsp"/>
        <div class="col-10 offset-2">
            <div class="row m-1">
                <h2 class="text-center">Order #${order.orderId}</h2>
            </div>
            <form method="post" action="/admin/update_order">
                <div class="row mx-1">
                    <div class="col-3 px-0">
                        <div class="card shadow bg-white rounded">
                            <h4 class="px-2">Order Overview:</h4>
                            <table class="table table-borderless w-100">
                                <tr>
                                    <td class=text-secondary"><b>Ordered by</b></td>
                                    <td>${order.customerByCustomerId.fullName}</td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Order Status</b></td>
                                    <td>
                                        <select name="status" class="custom-select mr-sm-2" >
                                            <option value="Processing" <c:if test="${order.status eq 'Processing'}">selected="selected"</c:if> >Processing</option>
                                            <option value="Shipping" <c:if test="${order.status eq 'Shipping'}">selected="selected"</c:if>>Shipping</option>
                                            <option value="Delivered" <c:if test="${order.status eq 'Delivered'}">selected="selected"</c:if>>Delivered</option>
                                            <option value="Completed" <c:if test="${order.status eq 'Completed'}">selected="selected"</c:if>>Completed</option>
                                            <option value="Cancelled" <c:if test="${order.status eq 'Cancelled'}">selected="selected"</c:if>>Cancelled</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Order Date</b></td>
                                    <td>${order.orderDate}</td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Payment Method</b></td>
                                    <td>
                                        <select name="paymentMethod" class="custom-select mr-sm-2" >
                                            <option value="Cash On Delivery"
                                                    <c:if test="${order.paymentMethod eq 'Cash On Delivery'}">selected="selected"</c:if>>
                                                Cash On Delivery</option>
                                            <option value="paypal"
                                                    <c:if test="${order.paymentMethod eq 'paypal'}">selected="selected"</c:if>>
                                                Paypal</option>
                                        </select>
                                    </td>
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
                                    <td class=text-secondary"><b>First Name</b></td>
                                    <td>
                                        <input type="text" name="rFirstname" class="form-control form-control-sm"
                                               placeholder="First Name" value="${order.rFirstname}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Last Name</b></td>
                                    <td>
                                        <input type="text" name="rLastname" class="form-control form-control-sm"
                                               placeholder="Last Name" value="${order.rLastname}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Phone</b></td>
                                    <td>
                                        <input type="text" name="rPhone" class="form-control form-control-sm"
                                               placeholder="Recipient Phone" value="${order.rPhone}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Address Line 1</b></td>
                                    <td>
                                        <input type="text" name="rAddressLine1" class="form-control form-control-sm"
                                               placeholder="Address Line 1" value="${order.rAddressLine1}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Address Line 2</b></td>
                                    <td>
                                        <input type="text" name="rAddressLine2" class="form-control form-control-sm"
                                               placeholder="Address Line 2" value="${order.rAddressLine2}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>City</b></td>
                                    <td>
                                        <input type="text" name="rCity" class="form-control form-control-sm"
                                               placeholder="City" value="${order.rCity}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>State</b></td>
                                    <td>
                                        <input type="text" name="rState" class="form-control form-control-sm"
                                               placeholder="State" value="${order.rState}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Zipcode</b></td>
                                    <td>
                                        <input type="text" name="rZipcode" class="form-control form-control-sm"
                                               placeholder="Zipcode" value="${order.rZipcode}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-secondary" style="width: 180px"><b>Country</b></td>
                                    <td>
                                        <select name="rCountry" class="custom-select mr-sm-2" >
                                            <c:forEach items="${mapCountries}" var="country">
                                                <option value="${country.value}"
                                                        <c:if test="${order.rCountry eq country.value}">selected="selected"</c:if>>
                                                        ${country.key}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                            </table>
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
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="orderDetail" varStatus="status" items="${order.orderDetailsByOrderId}">
                                            <tr>
                                                <th class="align-middle" scope="row">${status.index + 1}</th>
                                                <th class="d-flex align-middle">
                                                    <div>
                                                        <img src="data:image/jpg;base64,${orderDetail.bookByBookId.base64Image}"
                                                             style="height: 84px;width: auto;"/>
                                                    </div>
                                                    <div class="mx-2 my-4">
                                                            ${orderDetail.bookByBookId.title}
                                                    </div>
                                                </th>
                                                <th class="align-middle">${orderDetail.bookByBookId.author}</th>
                                                <th class="align-middle">
                                                    <input type="hidden" name="price" value="${orderDetail.bookByBookId.price}"/>
                                                    <fmt:formatNumber value="${orderDetail.bookByBookId.price}" type="currency"/>
                                                </th>
                                                <th class="align-middle">
                                                    <input type="hidden" name="bookId" value="${orderDetail.bookByBookId.bookId}"/>
                                                    <input type="hidden" name="quantity${status.index + 1}" class="form-control form-control-sm"
                                                           placeholder="Quantity" value="${orderDetail.quantity}"/>
                                                    ${orderDetail.quantity}
                                                </th>
                                                <th class="text-right align-middle"><fmt:formatNumber value="${orderDetail.subtotal}" type="currency"/></th>
                                                <th class="text-right align-middle">
                                                    <a href="/admin/remove_book_from_order?id=${orderDetail.bookByBookId.bookId}">
                                                        <button type="button"  class="btn btn-primary btn-sm ">
                                                            Remove Books <i class="fas fa-book"></i>
                                                        </button>
                                                    </a>
                                                </th>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <th scope="col" class="sticky-header" colspan="5"></th>
                                            <th scope="col" class="sticky-header text-right">
                                                Subtotal:<fmt:formatNumber value="${order.subtotal}" type="currency"/><br>
                                                <div class="form-group row text-right">
                                                    <div class="col">
                                                        <div class="input-group" style="text-align:right;">
                                                            <label for="tax" >Tax:&nbsp;</label>
                                                            <input class="form-control form-control-sm border-info text-right"
                                                                   type="text" name="tax" placeholder="Tax"
                                                                   style="width: 40px"  id="tax"
                                                                   value="<fmt:formatNumber value="${order.tax}" type="number" maxFractionDigits="2"/>" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group row text-right">
                                                    <div class="col">
                                                        <div class="input-group" style="text-align:right;">
                                                            <label for="shippingFee" >Shipping Fee:&nbsp;</label>
                                                            <input class="form-control form-control-sm border-info text-right"
                                                                   type="text" name="shippingFee" placeholder="Shipping Fee"
                                                                   style="width: 40px"  id="shippingFee" value="${order.shippingFee}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                TOTAL: <fmt:formatNumber value="${order.total}" type="currency"/><br>
                                            </th>
                                            <th>

                                            </th>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>

                            </div>
                        </div>
                        <a href="javascript:showAddBookPopup()">
                            <button type="button" class="btn btn-outline-primary ">Add Books <i class="fas fa-book"></i></button>
                        </a>
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a href="/admin/list_orders">
                            <button type="button" class="btn btn-secondary">Cancel</button>
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    function showAddBookPopup(){
        var width = 500;
        var height = 200;
        var left = (screen.width - width) / 2;
        var top = (screen.height - height) / 2;
        window.open('add_book_form','_blank',
            'width = ' + width + ', height = ' + height + ', top = '+ top + ', left = '+ left)
    }
</script>
</body>
</html>