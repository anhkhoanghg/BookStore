
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
    <form action="/admin/add_book_to_order" method="post">
        <div class="form-group">
            <h2>Add book to order #${order.orderId}</h2>
            <label for="book">Select a book</label>
            <select class="form-control" name="bookId" id="book">
                <c:forEach var="book" items="${booksList}" >
                    <option value="${book.bookId}">${book.title} - ${book.author}</option>
                </c:forEach>
            </select>
            <label for="quantity">Number of copies</label>
            <select class="form-control" name="quantity" id="quantity">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
            <div class="my-3">
                <button type="submit" class="btn btn-outline-primary">Add</button>
                <button type="button" class="btn btn-outline-secondary" onclick="javascript:self.close();">Cancel</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
