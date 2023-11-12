<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <title>Your transactions history</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />
    <link rel="stylesheet" href="/css/profile.css">

</head>
<body>
<%@include file="/components/Header.jsp"%>

<div class="container pb-3">
    <div class="table-responsive-lg" style="min-height: 400px">
        <c:if test="${fn:length(listOrders) == 0}">
            <h3>You have not placed any order.</h3>
        </c:if>
        <c:if test="${fn:length(listOrders) > 0}">
            <h3>Your Order History</h3>
            <table class="table table-bordered table-striped table-hover">
                <thead class="thead-dark">
                <tr>
                    <th>No.</th>
                    <th>Order ID</th>
                    <th>Quantity</th>
                    <th>Total Amount</th>
                    <th>Order Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listOrders}" var="order" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${order.orderId}</td>
                        <td>
                            <span class="font-weight-bold">${order.bookCopies}</span>
                        </td>

                        <td>
                            <span><fmt:formatNumber value="${order.total}" type="currency" /></span>
                        </td>

                        <td>
                            <span>${order.orderDate}</span>
                        </td>
                        <td>
                            <span>${order.status}</span>
                        </td>
                        <td>
                            <a href="/show_order_detail?id=${order.orderId}" class="btn btn-danger btn-sm">View Details</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot>
                </tfoot>
            </table>
        </c:if>
    </div>
</div>

<%@include file="/components/Footer.jsp"%>
<jsp:include page="/importLib.jsp"/>


</body>
</html>