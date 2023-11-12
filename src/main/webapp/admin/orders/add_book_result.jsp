
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Add book to order</title>
    <jsp:include page="/import.jsp"/>
</head>
<body>
<div class="container">
    <div class="d-flex text-center">
        The book ${book.title} has been added to the order ID ${order.orderId}.
    </div>
    <div class="d-flex align-items-center">
        <button type="button" class="btn btn-outline-secondary" onclick="javascript:self.close();">Close</button>
    </div>

</div>
<script>
    window.onunload = function () {
        window.opener.location.reload();
    }
</script>
</body>
</html>
